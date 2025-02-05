//
//  Weather.swift
//  CompareWeather
//
//  Created by Santos Ángel Pardo Ramos on 2/2/25.
//

import Foundation

final class WeatherInfo {

    let temperature: Double
    let minTemperature: Double?
    let maxTemperature: Double?
    let rainProbabily: Int // (0-100)
    let cloudiness: Int? // (0-100)
    let snowProbability: Int // (0-100)
    let windSpeed: Double
    let windDirection: Int? //(0-360)
    let totalPrecipitation: Double

    init(temperature: Double,
         minTemperature: Double?,
         maxTemperature: Double?,
         rainProbabily: Int,
         cloudiness: Int? = nil,
         snowProbability: Int,
         windSpeed: Double,
         windDirection: Int? = nil,
         totalPrecipitation: Double) {
        self.temperature = temperature
        self.minTemperature = minTemperature
        self.maxTemperature = maxTemperature
        self.rainProbabily = rainProbabily
        self.cloudiness = cloudiness
        self.snowProbability = snowProbability
        self.windSpeed = windSpeed
        self.windDirection = windDirection
        self.totalPrecipitation = totalPrecipitation
    }
}

final class WeatherDetail {
    let date: Date
    let weatherInfo: WeatherInfo

    init(date: Date, weatherInfo: WeatherInfo) {
        self.date = date
        self.weatherInfo = weatherInfo
    }
}

final class WeatherDaily {

    let date: Date
    let hourlyWeather: [WeatherDetail]
    let averageWeather: WeatherInfo

    init(date: Date, hourlyWeather: [WeatherDetail], averageWeather: WeatherInfo) {
        self.date = date
        self.hourlyWeather = hourlyWeather
        self.averageWeather = averageWeather
    }
}

final class Forecast {

    public enum ForecastFont: String, CaseIterable {
        case WeatherApi
    }

    let font: ForecastFont
    let place: String
    let weatherDaily: [WeatherDaily]

    init(font: ForecastFont, place: String, weatherDaily: [WeatherDaily]) {
        self.font = font
        self.place = place
        self.weatherDaily = weatherDaily
    }
}
