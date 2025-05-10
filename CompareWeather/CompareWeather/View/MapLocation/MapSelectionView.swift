import SwiftUI
import MapKit

struct MapSelectionView: View {

    enum MapSelectionViewNavigation: Identifiable {
        case toCompareWeather

        var id: Self { self }
    }

    @StateObject var viewModel = MapSelectionViewModel()
    @State private var selectedScreen: MapSelectionViewNavigation?

    var body: some View {
        ZStack {
            MapViewRepresentable(selectedLocation: $viewModel.selectedLocation)
                .ignoresSafeArea()
            if viewModel.selectedLocation != nil {
                VStack {
                    Spacer()
                    VStack(alignment: .center, spacing: 4) {
                        Text(viewModel.coordinateInfo)
                            .padding()
                            .font(WeatherSize.medium.size)
                            .foregroundColor(WeatherColor.secondary.color)
                            .background(WeatherColor.primary.color) // Efecto translúcido
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                            .padding()
                        Button(action: {
                            selectedScreen = .toCompareWeather
                        }) {
                            Text(viewModel.searchForecastText)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(WeatherColor.primary.color)
                                .foregroundColor(WeatherColor.secondary.color)
                                .cornerRadius(10)
                        }
                    }
                    .padding()
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(WeatherColor.primary.color, lineWidth: 0)
                    )
                    .background(WeatherColor.primary.color.opacity(0.3))
                    .padding()
                }
            }
        }
        .toolbar {
            WeatherToolbarView()
        }
        .fullScreenCover(item: $selectedScreen) { screen in
            NavigationStack {
                switch screen {
                case .toCompareWeather:
                    if let selectedLocation = viewModel.selectedLocation {
                        CompareWeatherView(viewModel: .init(place: Place(
                            name: "",
                            lat: selectedLocation.latitude.description,
                            lon: selectedLocation.longitude.description,
                            display_name: ""
                        )))
                    }
                }
            }
        }
    }

    struct MapViewRepresentable: UIViewRepresentable {
        @Binding var selectedLocation: CLLocationCoordinate2D?

        func makeUIView(context: Context) -> MKMapView {
            let mapView = MKMapView()
            mapView.delegate = context.coordinator
            mapView.showsUserLocation = true
            mapView.isZoomEnabled = true
            mapView.isScrollEnabled = true

            let tapGesture = UITapGestureRecognizer(target: context.coordinator, action: #selector(Coordinator.handleTap(_:)))
            mapView.addGestureRecognizer(tapGesture)

            return mapView
        }

        func updateUIView(_ uiView: MKMapView, context: Context) {
            uiView.removeAnnotations(uiView.annotations)

            if let selectedLocation {
                let annotation = MKPointAnnotation()
                annotation.coordinate = selectedLocation
                uiView.addAnnotation(annotation)
            }
        }

        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }

        class Coordinator: NSObject, MKMapViewDelegate {
            var parent: MapViewRepresentable

            init(_ parent: MapViewRepresentable) {
                self.parent = parent
            }

            @objc func handleTap(_ gesture: UITapGestureRecognizer) {
                let mapView = gesture.view as! MKMapView
                let touchPoint = gesture.location(in: mapView)
                let coordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)

                DispatchQueue.main.async {
                    self.parent.selectedLocation = coordinate
                }
            }
        }
    }
}
    #Preview {
        MapSelectionView(viewModel: .init())
    }
