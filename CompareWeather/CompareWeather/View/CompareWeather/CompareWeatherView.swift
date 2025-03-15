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

    @ObservedObject var viewModel: CompareWeatherViewModel
    @Environment(\.dismiss) private var dismiss
    @State private var selectedScreen: CompareWeatherViewNavigation?

    var body: some View {
        VStack(spacing: 0) { // Espaciado mínimo entre elementos
            VStack(spacing: 2) { // Menos espaciado interno
                Text(viewModel.placeName)
                    .font(.largeTitle)
                    .bold()
                Text(viewModel.coordinates)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            ScrollView { // Scroll vertical
                ScrollView(.horizontal) { // Scroll horizontal
                    HStack(alignment: .top, spacing: 20) {
                        ForEach(viewModel.forecasts, id: \.id) { forecast in
                            VStack(alignment: .leading) {
                                Text(forecast.font.rawValue)
                                    .font(.title2)
                                    .bold()
                                    .padding(.bottom, 5)

                                ForEach(forecast.weatherDaily, id: \.id) { daily in
                                    VStack(alignment: .leading, spacing: 5) {
                                        Text(FormattedDate.string(from: daily.date))
                                            .font(.headline)

                                        Text("🌡 Temp: \(daily.averageWeather.temperature, specifier: "%.1f")°C")
                                        Text("📉 Min: \(daily.averageWeather.minTemperature ?? 0, specifier: "%.1f")°C")
                                        Text("📈 Max: \(daily.averageWeather.maxTemperature ?? 0, specifier: "%.1f")°C")
                                        Text("🌧 Lluvia: \(daily.averageWeather.rainProbabily)%")
                                        Text("☁️ Nubes: \(daily.averageWeather.cloudiness ?? 0)%")
                                        Text("❄️ Nieve: \(daily.averageWeather.snowProbability)%")
                                        Text("💨 Viento: \(daily.averageWeather.windSpeed, specifier: "%.1f") m/s")
                                        Text("🧭 Dirección: \(daily.averageWeather.windDirection ?? 0)°")
                                        Text("☔️ Precipitación: \(daily.averageWeather.totalPrecipitation, specifier: "%.1f") mm")
                                    }
                                    .padding()
                                    .background(Color.gray.opacity(0.1))
                                    .cornerRadius(10)
                                    .onTapGesture {
                                        selectedScreen = .toDetail(weatherDaily: daily)
                                    }
                                }
                            }
                            .padding()
                            .frame(maxWidth: 200)
                            .background(Color.white)
                            .cornerRadius(15)
                            .shadow(radius: 5)
                        }
                    }
                    .padding()
                }
            }
            .padding(.top, 5) // Evita separación grande debajo de la cabecera*/
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(viewModel.close) {
                    dismiss()
                }
            }
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

    func getDetailView(date: Date) -> CompareWeatherDetailView {
        CompareWeatherDetailView(viewModel: CompareWeatherDetailViewModel(weathersDaily: viewModel.getWeathersDaily(date: date), place: viewModel.place))
    }
}

struct FormattedDate {
    static func string(from date: Date, format: String = "E, d MMM") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: date)
    }
}
