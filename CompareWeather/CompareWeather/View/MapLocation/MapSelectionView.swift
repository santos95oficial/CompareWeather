import SwiftUI
import MapKit

struct MapSelectionView: View {
    
    enum MapSelectionViewNavigation: Identifiable {
        case toCompareWeather
        
        var id: Self { self }
    }
    
    @StateObject var viewModel = MapSelectionViewModel()
    @State private var selectedLocation: CLLocationCoordinate2D?
    @State private var selectedScreen: MapSelectionViewNavigation?
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            MapViewRepresentable(selectedLocation: $selectedLocation)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                if let selectedLocation {
                    VStack {
                        Spacer()
                        VStack {
                            Text(String.init(format: viewModel.coordinateInfo, selectedLocation.latitude.description, selectedLocation.longitude.description))
                                .padding()
                                .background(.ultraThinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding()
                            
                            Button(action: {
                                selectedScreen = .toCompareWeather
                            }) {
                                Text(viewModel.searchForecastText)
                                    .frame(maxWidth: .infinity)
                                    .padding()
                                    .background(Color.green)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                            }
                            .padding(.top)
                        }
                        .padding()
                    }
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(viewModel.close) {
                    dismiss()
                }
            }
        }
        .fullScreenCover(item: $selectedScreen) { screen in
            NavigationStack {
                switch screen {
                case .toCompareWeather:
                    if let selectedLocation {
                        CompareWeatherView(viewModel: .init(place: Place(
                            name: "From map",
                            lat: selectedLocation.latitude.description,
                            lon: selectedLocation.longitude.description,
                            display_name: ""
                        )))
                    }
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
        // Do nothing
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

#Preview {
    MapSelectionView(viewModel: .init())
}
