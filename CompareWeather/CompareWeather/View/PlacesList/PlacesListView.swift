//
//  PlacesListView.swift
//  CompareWeather
//
//  Created by Santos Ángel Pardo Ramos on 4/2/25.
//

import SwiftUI
import MapKit

struct PlacesListView: View {
    let userText: String

    @StateObject private var viewModel = PlacesListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                Text(viewModel.titleText)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                if viewModel.isLoading {
                    ProgressView(viewModel.loadingText) // Indicador de carga
                } else {
                    List(viewModel.places) { place in
                        let location = CLLocationCoordinate2D(latitude: Double(place.lat) ?? 0.0, longitude: Double(place.lon) ?? 0.0)
                        NavigationLink(destination: CompareWeatherView(location: location)) {
                            VStack(alignment: .leading) {
                                Text(place.name)
                                    .font(.headline)
                                Text(place.display_name)
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            .onAppear {
                viewModel.fetchPlaces(userText) // Llamar a la API cuando la vista aparece
            }
        }
    }
}

#Preview {
    PlacesListView(userText: "Valladolid")
}
