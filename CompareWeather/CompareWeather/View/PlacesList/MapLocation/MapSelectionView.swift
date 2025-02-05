//
//  MapSelectionView.swift
//  CompareWeather
//
//  Created by Santos Ángel Pardo Ramos on 5/2/25.
//

import SwiftUI
import MapKit

// Define el enum DestinationMap conforme a Hashable
enum DestinationMap: Hashable {
    case newView
}

struct MapSelectionView: View {
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194), // San Francisco
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
    )

    @State private var selectedLocation: CLLocationCoordinate2D?
    @State private var navigationPath = NavigationPath()  // Gestión del stack de navegación

    var body: some View {
        NavigationStack(path: $navigationPath) { // Usamos NavigationStack para habilitar la navegación
            ZStack {
                // 📌 Mapa a pantalla completa
                Map(position: $cameraPosition) {
                    if let location = selectedLocation {
                        Marker("Seleccionado", coordinate: location)
                    }
                }
                .mapControls {
                    MapUserLocationButton()
                    MapCompass()
                }
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onEnded { value in
                            let coordinate = convertTapToCoordinate(location: value.location)
                            selectedLocation = coordinate
                        }
                )
                .ignoresSafeArea() // 🚀 Hace que el mapa ocupe toda la pantalla

                // 📌 Muestra las coordenadas en un recuadro flotante
                if let location = selectedLocation {
                    VStack {
                        Spacer()
                        VStack {
                            Text("📍 Coordenadas: \(location.latitude), \(location.longitude)")
                                .padding()
                                .background(.ultraThinMaterial)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                .padding()

                            // Botón para navegar a la nueva vista
                            Button(action: {
                                // Al presionar el botón, navegamos al nuevo destino
                                navigationPath.append(DestinationMap.newView)
                            }) {
                                Text("Abrir nueva vista")
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
            // Declaramos los destinos de navegación con DestinationMap
            .navigationDestination(for: DestinationMap.self) { destination in
                switch destination {
                case .newView:
                    if let selectedLocation {
                        CompareWeatherView(location: selectedLocation)
                    }
                }
            }
        }
    }

    // Convertir toque en coordenadas de mapa
    private func convertTapToCoordinate(location: CGPoint) -> CLLocationCoordinate2D {
        let mapPoint = MKMapPoint(x: location.x, y: location.y)
        return mapPoint.coordinate
    }
}


#Preview {
    MapSelectionView()
}
