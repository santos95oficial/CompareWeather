//
//  WeatherEngine.swift
//  CompareWeather
//
//  Created by Santos Ángel Pardo Ramos on 2/2/25.
//

import Foundation

final class WeatherEngine {

    static func fetchWeather(for location: String, completion: @escaping ([Forecast]) -> Void) {
        var forecasts: [Forecast] = []
        let dispatchGroup = DispatchGroup()

        for font in Forecast.ForecastFont.allCases {
            dispatchGroup.enter()

            switch font {
            case .WeatherApi:
                WeatherAPIClient.fetchWeather(for: location) { forecast in
                    if let forecast {
                        forecasts.append(forecast)
                        forecasts.append(forecast)
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

    static func fetchWeather(lat: Double, lon: Double, completion: @escaping ([Forecast]) -> Void) {
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
