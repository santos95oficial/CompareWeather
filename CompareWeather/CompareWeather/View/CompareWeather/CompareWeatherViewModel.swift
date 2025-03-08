//
//  CompareWeatherViewModel.swift
//  CompareWeather
//
//  Created by Santos Ángel Pardo Ramos on 13/2/25.
//

import Foundation

protocol CompareWeatherViewModelType {
    var name: String { get }
}

public final class CompareWeatherViewModel: CompareWeatherViewModelType, ObservableObject {

    private let place: Place

    init(place: Place) {
        self.place = place
    }

    var name: String {
        place.name
    }
}
