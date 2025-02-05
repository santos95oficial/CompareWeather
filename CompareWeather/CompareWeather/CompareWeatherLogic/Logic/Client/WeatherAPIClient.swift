//
//  WeatherAPIClient.swift
//  CompareWeather
//
//  Created by Santos Ángel Pardo Ramos on 2/2/25.
//

import Foundation

final class WeatherAPIClient {

    static func fetchWeather(lat: Double, lon: Double, days: Int = 3, completion: @escaping (Forecast?) -> Void) {
        let location = "\(lat),\(lon)"
        Self.fetchWeather(for: location, days: days, completion: completion)
    }

    static func fetchWeather(for location: String, days: Int = 3, completion: @escaping (Forecast?) -> Void) {

        let apiKey = "5f49daa742f644f0a21203738240110"
        let urlString = "https://api.weatherapi.com/v1/forecast.json?key=\(apiKey)&q=\(location)&days=\(days)&aqi=no&alerts=no"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"

        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data,
                  error == nil
            else {
                completion(nil)
                return
            }

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                let apiResponse = try decoder.decode(WeatherAPIResponse.self, from: data)

                let weatherDaily = apiResponse.forecast.forecastday.map { dayAPI -> WeatherDaily in
                    let date = dateFormatter.date(from: dayAPI.date) ?? Date()

                    let averageWeather = WeatherInfo(
                        temperature: dayAPI.day.avgtemp_c,
                        minTemperature: dayAPI.day.mintemp_c,
                        maxTemperature: dayAPI.day.maxtemp_c,
                        rainProbabily: dayAPI.day.daily_chance_of_rain,
                        cloudiness: nil, // No disponible en el JSON diario
                        snowProbability: dayAPI.day.daily_chance_of_snow,
                        windSpeed: dayAPI.day.maxwind_kph,
                        windDirection: nil, // No disponible en el JSON diario,
                        totalPrecipitation: dayAPI.day.totalprecip_mm
                    )

                    let hourlyWeather = dayAPI.hour.map { hourAPI -> WeatherDetail in
                        let date = Date(timeIntervalSince1970: TimeInterval(hourAPI.time_epoch))
                        let weatherInfo = WeatherInfo(
                            temperature: hourAPI.temp_c,
                            minTemperature: nil,
                            maxTemperature: nil,
                            rainProbabily: hourAPI.chance_of_rain,
                            cloudiness: hourAPI.cloud,
                            snowProbability: hourAPI.chance_of_snow,
                            windSpeed: hourAPI.wind_kph,
                            windDirection: hourAPI.wind_degree,
                            totalPrecipitation: hourAPI.precip_mm
                        )
                        return WeatherDetail(date: date, weatherInfo: weatherInfo)
                    }

                    return WeatherDaily(date: date, hourlyWeather: hourlyWeather, averageWeather: averageWeather)
                }

                let forecast = Forecast(font: .WeatherApi,
                                        place: apiResponse.location.name,
                                        weatherDaily: weatherDaily)
                completion(forecast)

            } catch {
                print("Error al decodificar JSON: \(error)")
                completion(nil)
            }
        }.resume()
    }
}
