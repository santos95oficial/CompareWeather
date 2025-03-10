//
//  WeatherEngine.swift
//  CompareWeather
//
//  Created by Santos Ángel Pardo Ramos on 2/2/25.
//

import Foundation

final class WeatherEngine {

    static func fetchWeather(lat: Double?, lon: Double?, completion: @escaping ([Forecast]) -> Void) {
        guard let lat, let lon else {
            completion([])
            return
        }
        var forecasts: [Forecast] = []
        let dispatchGroup = DispatchGroup()

        for font in Forecast.ForecastFont.allCases {
            dispatchGroup.enter()

            switch font {
            case .WeatherApi:
                WeatherAPIClient.fetchWeather(lat: lat, lon: lon) { forecast in
                    if let forecast {
                        forecasts.append(forecast)
                    }
                    dispatchGroup.leave()
                }
            }
        }

        dispatchGroup.notify(queue: .main) {
            completion(forecasts)
        }
    }
}
