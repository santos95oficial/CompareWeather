//
//  CompareWeatherViewModel.swift
//  CompareWeather
//
//  Created by Santos Ángel Pardo Ramos on 13/2/25.
//

import Foundation

protocol CompareWeatherViewModelType {
    var forecast: [Forecast] { get }
    var close: String { get }
    var placeName: String { get }
    var coordinates: String { get }
    func fetchForecast()
}

public final class CompareWeatherViewModel: CompareWeatherViewModelType, ObservableObject {

    private let place: Place
    @Published var forecast: [Forecast] = []

    var close: String {
        "Cerrar"
    }

    var placeName: String {
        place.name
    }

    var coordinates: String {
        "📍 \(place.lat) - \(place.lon)"
    }

    init(place: Place) {
        self.place = place
    }

    func fetchForecast() {
        WeatherEngine.fetchWeather(lat: Double(place.lat), lon: Double(place.lon)) { forecast in
            self.forecast = forecast
        }
    }
}
