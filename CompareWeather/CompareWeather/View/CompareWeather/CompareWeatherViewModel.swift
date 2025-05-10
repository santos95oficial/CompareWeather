//
//  CompareWeatherViewModel.swift
//  CompareWeather
//
//  Created by Santos Ángel Pardo Ramos on 13/2/25.
//

import Foundation
import SwiftUI

protocol CompareWeatherViewModelType {
    var place: Place { get }
    var forecasts: [Forecast] { get }
    var coordinates: String { get }
    func fetchForecast()
    func getWeathersDaily(date: Date) -> [WeatherDaily]

    func temperature(forecast: WeatherInfo) -> String
    func minTemperature(forecast: WeatherInfo) -> String
    func maxTemperature(forecast: WeatherInfo) -> String
    func rainProbability(forecast: WeatherInfo) -> String
    func cloudiness(forecast: WeatherInfo) -> String
    func snowProbability(forecast: WeatherInfo) -> String
    func windSpeed(forecast: WeatherInfo) -> String
    func windDirection(forecast: WeatherInfo) -> String
    func precipitation(forecast: WeatherInfo) -> String
}

public final class CompareWeatherViewModel: CompareWeatherViewModelType, ObservableObject {

    var place: Place
    @Published var forecasts: [Forecast] = []

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

    func temperature(forecast: WeatherInfo) -> String {
        String(format: "🌡 Temp: %.1f°C", forecast.temperature)
    }

    func minTemperature(forecast: WeatherInfo) -> String {
        String(format: "📉 Min: %.1f°C", forecast.minTemperature ?? 0)
    }

    func maxTemperature(forecast: WeatherInfo) -> String {
        String(format: "📈 Max: %.1f°C", forecast.maxTemperature ?? 0)
    }

    func rainProbability(forecast: WeatherInfo) -> String {
        "🌧 Lluvia: \(forecast.rainProbabily)%"
    }

    func cloudiness(forecast: WeatherInfo) -> String {
        "☁️ Nubes: \(forecast.cloudiness ?? 0)%"
    }

    func snowProbability(forecast: WeatherInfo) -> String {
        "❄️ Nieve: \(forecast.snowProbability)%"
    }

    func windSpeed(forecast: WeatherInfo) -> String {
        String(format: "💨 Viento: %.1f m/s", forecast.windSpeed)
    }

    func windDirection(forecast: WeatherInfo) -> String {
        "🧭 Dirección: \(forecast.windDirection ?? 0)°"
    }

    func precipitation(forecast: WeatherInfo) -> String {
        String(format: "☔️ Precipitación: %.1f mm", forecast.totalPrecipitation)
    }
}
