//
//  WeatherApiCodable.swift
//  CompareWeather
//
//  Created by Santos Ángel Pardo Ramos on 2/2/25.
//

import Foundation

struct WeatherAPIResponse: Codable {
    let location: Location
    let forecast: ForecastAPI
}

struct Location: Codable {
    let name: String
}

struct ForecastAPI: Codable {
    let forecastday: [ForecastDayAPI]
}

struct ForecastDayAPI: Codable {
    let date: String
    let day: DayWeather
    let hour: [HourWeather]
}

struct DayWeather: Codable {
    let avgtemp_c: Double
    let maxtemp_c: Double
    let mintemp_c: Double
    let daily_chance_of_rain: Int
    let daily_chance_of_snow: Int
    let maxwind_kph: Double
    let totalprecip_mm: Double
}

struct HourWeather: Codable {
    let time_epoch: Int
    let temp_c: Double
    let chance_of_rain: Int
    let chance_of_snow: Int
    let cloud: Int
    let wind_kph: Double
    let wind_degree: Int
    let precip_mm: Double
}
