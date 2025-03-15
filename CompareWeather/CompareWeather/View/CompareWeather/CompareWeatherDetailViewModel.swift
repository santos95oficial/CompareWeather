//
//  CompareWeatherDetailViewModel.swift
//  CompareWeather
//
//  Created by Santos Ángel Pardo Ramos on 11/3/25.
//


import Foundation

protocol CompareWeatherDetailViewModelType {
    var weathersDaily: [WeatherDaily] { get }
    var close: String { get }
}

public final class CompareWeatherDetailViewModel: ObservableObject, CompareWeatherDetailViewModelType {

    var weathersDaily: [WeatherDaily]
    private let place: Place

    init(weathersDaily: [WeatherDaily], place: Place) {
        self.weathersDaily = weathersDaily
        self.place = place
    }

    var close: String {
        "Cerrar"
    }
}
