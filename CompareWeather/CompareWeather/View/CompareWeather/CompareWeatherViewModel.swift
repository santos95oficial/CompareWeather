//
//  CompareWeatherViewModel.swift
//  CompareWeather
//
//  Created by Santos Ángel Pardo Ramos on 13/2/25.
//

import Foundation

protocol CompareWeatherViewModelType {
    var place: Place { get }
    var forecasts: [Forecast] { get }
    var close: String { get }
    var placeName: String { get }
    var coordinates: String { get }
    func fetchForecast()
    func getWeathersDaily(date: Date) -> [WeatherDaily]
}

public final class CompareWeatherViewModel: CompareWeatherViewModelType, ObservableObject {

    var place: Place
    @Published var forecasts: [Forecast] = []

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
            self.forecasts = forecast
        }
    }

    func getWeathersDaily(date: Date) -> [WeatherDaily] {
        forecasts.compactMap { $0.weatherDaily.first { $0.date == date } }
    }
}
