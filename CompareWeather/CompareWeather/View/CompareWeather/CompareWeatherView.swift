//
//  CompareWeatherView.swift
//  CompareWeather
//
//  Created by Santos Ángel Pardo Ramos on 5/2/25.
//

import SwiftUI
import MapKit

struct CompareWeatherView: View {
    
    enum CompareWeatherViewNavigation: Identifiable {
        case toDetail(weatherDaily: WeatherDaily)
        
        var id: String {
            switch self {
            case .toDetail(let weatherDaily):
                return weatherDaily.id.uuidString
            }
        }
    }
    
    @StateObject var viewModel: CompareWeatherViewModel
    @State private var selectedScreen: CompareWeatherViewNavigation?
    
    var body: some View {
        ZStack {
            WeatherBackgroundView()
            VStack(spacing: 0) { // Espaciado mínimo entre elementos
                VStack(spacing: 2) { // Menos espaciado interno3
                        Text(viewModel.forecasts.first?.place ?? viewModel.coordinates)
                        .font(WeatherSize.enormous.size)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(WeatherColor.secondary.color)
                        .padding()
                }
                ScrollView { // Scroll vertical
                    ScrollView(.horizontal) { // Scroll horizontal
                        HStack(alignment: .top, spacing: 20) {
                            ForEach(viewModel.forecasts, id: \.id) { forecast in
                                VStack(alignment: .leading) {
                                    HStack {
                                        Spacer()
                                        Text(forecast.font.rawValue)
                                            .font(WeatherSize.large.size)
                                            .foregroundColor(WeatherColor.secondary.color)
                                            .padding()
                                        Spacer()
                                    }
                                    ForEach(forecast.weatherDaily, id: \.id) { daily in
                                        VStack(alignment: .leading, spacing: 2) {
                                            HStack {
                                                Spacer()
                                                Text(getDate(from: daily.date))
                                                    .font(WeatherSize.large.size)
                                                    .foregroundColor(WeatherColor.secondary.color)
                                                    .padding(.vertical, 4)
                                                    .fontWeight(.bold)
                                                Spacer()
                                            }

                                            getDataInfo(viewModel.temperature(forecast: daily.averageWeather))
                                            getDataInfo(viewModel.minTemperature(forecast: daily.averageWeather))
                                            getDataInfo(viewModel.maxTemperature(forecast: daily.averageWeather))
                                            getDataInfo(viewModel.rainProbability(forecast: daily.averageWeather))
                                            getDataInfo(viewModel.cloudiness(forecast: daily.averageWeather))
                                            getDataInfo(viewModel.snowProbability(forecast: daily.averageWeather))
                                            getDataInfo(viewModel.windSpeed(forecast: daily.averageWeather))
                                            getDataInfo(viewModel.windDirection(forecast: daily.averageWeather))
                                            getDataInfo(viewModel.precipitation(forecast: daily.averageWeather))
                                        }
                                        .padding(8) // Reduce padding exterior
                                        .background(Color.gray.opacity(0.1))
                                        .cornerRadius(10)
                                        .onTapGesture {
                                            selectedScreen = .toDetail(weatherDaily: daily)
                                        }
                                    }

                                }
                                .padding()
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .background(.clear)
                                .cornerRadius(12)
                                .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 3)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(WeatherColor.primary.color, lineWidth: 2)
                                )
                            }
                        }
                        .padding()
                    }
                }
            }
            .toolbar {
                WeatherToolbarView()
            }
            .onAppear {
                viewModel.fetchForecast()
            }
            .fullScreenCover(item: $selectedScreen) { screen in
                NavigationStack {
                    switch screen {
                    case .toDetail(let weatherDaily):
                        getDetailView(date: weatherDaily.date)
                    }
                }
            }
        }
    }
    
    func getDetailView(date: Date) -> CompareWeatherDetailView {
        CompareWeatherDetailView(viewModel: CompareWeatherDetailViewModel(weathersDaily: viewModel.getWeathersDaily(date: date), place: viewModel.place))
    }

    @ViewBuilder
    func getDataInfo(_ text: String) -> some View {
        Text(text)
            .font(WeatherSize.smallPlus.size)
            .foregroundColor(WeatherColor.black.color)
            .padding(.vertical, 2) // más compacto
    }

    func getDate(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.setLocalizedDateFormatFromTemplate("EEE, d MMM")
        return formatter.string(from: date)
    }
}
