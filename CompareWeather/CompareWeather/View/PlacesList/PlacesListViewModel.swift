//
//  PlacesListViewModel.swift
//  CompareWeather
//
//  Created by Santos Ángel Pardo Ramos on 4/2/25.
//

import Foundation
import SwiftUI

protocol PlacesListViewModelType {
    var loadingText: String { get }
    var places: [Place] { get }
    var isLoading: Bool { get }
    var titleText: String { get }
    var close: String { get }
    var showError: Bool { get }
    var errorMessage: String? { get }
    var errorTitle: String { get }
}

public final class PlacesListViewModel: ObservableObject, PlacesListViewModelType {

    @Published var places: [Place] = []
    @Published var isLoading = false
    @Published var showError: Bool = false
    @Published var errorMessage: String?

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

    var errorTitle: String {
        "Error"
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
                self.showError = true
                self.errorMessage = "No se ha podido obtener ninguna información"
                return
            }

            do {
                let decodedResponse = try JSONDecoder().decode([Place].self, from: data)
                DispatchQueue.main.async {
                    self.places = decodedResponse
                }
            } catch {
                self.showError = true
                self.errorMessage = "No se ha podido obtener ninguna información"
            }
        }.resume()
    }
}
