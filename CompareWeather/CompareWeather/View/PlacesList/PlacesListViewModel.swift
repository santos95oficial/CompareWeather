//
//  PlacesListViewModel.swift
//  CompareWeather
//
//  Created by Santos Ángel Pardo Ramos on 4/2/25.
//

import Foundation
import SwiftUI

struct Place: Codable, Identifiable {
    let id = UUID() // Para hacer la estructura Identifiable en SwiftUI
    let name: String
    let lat: String
    let lon: String
    let display_name: String
}

protocol PlacesListViewModelType {
    var loadingText: String { get }
    var places: [Place] { get }
    var isLoading: Bool { get }
    var titleText: String { get }
    var close: String { get }

    func placeSelected(_ place: Place)
}

public final class PlacesListViewModel: ObservableObject, PlacesListViewModelType {

    @Published var places: [Place] = []
    @Published var isLoading = false

    private let place: String

    init(place: String) {
        self.place = place
    }

    var loadingText: String {
        "Cargando..."
    }

    var titleText: String {
        "Seleccione una ubicación"
    }

    var close: String {
        "Cerrar"
    }

    func placeSelected(_ place: Place) {

    }

    func fetchPlaces() {
        guard !place.isEmpty,
              let url = URL(string: "https://nominatim.openstreetmap.org/search?city=\(place)&format=json") else {
            return
        }

        isLoading = true

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }

            guard let data,
                  error == nil
            else {
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode([Place].self, from: data)
                DispatchQueue.main.async {
                    self.places = decodedResponse
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
}
