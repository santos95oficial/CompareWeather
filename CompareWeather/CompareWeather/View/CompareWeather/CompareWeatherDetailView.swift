import SwiftUI

enum WeatherMetric: String, CaseIterable, Identifiable {
    case temperature = "Temperature"
    case windSpeed = "Wind Speed"
    case rainProbability = "Rain Probability"
    case cloudiness = "Cloudiness"
    case snowProbability = "Snow Probability"
    case totalPrecipitation = "Precipitation"

    var id: String { self.rawValue }
}

struct WeatherColumnView: View {
    let weatherDaily: WeatherDaily
    let selectedMetric: WeatherMetric

    private func value(for detail: WeatherDetail) -> String {
        let info = detail.weatherInfo
        switch selectedMetric {
        case .temperature:
            return String(format: "%.1f°C", info.temperature)
        case .windSpeed:
            return String(format: "💨 %.1f km/h", info.windSpeed)
        case .rainProbability:
            return "🌧 \(info.rainProbabily)%"
        case .cloudiness:
            return info.cloudiness.map { "☁️ \($0)%" } ?? "-"
        case .snowProbability:
            return "❄️ \(info.snowProbability)%"
        case .totalPrecipitation:
            return String(format: "💧 %.1f mm", info.totalPrecipitation)
        }
    }

    var body: some View {
            VStack(alignment: .leading) {
                Text(weatherDaily.date, style: .date)
                    .font(.headline)
                    .padding(.bottom, 4)

                ForEach(weatherDaily.hourlyWeather, id: \..date) { detail in
                    HStack {
                        Text(detail.date, style: .time)
                            .frame(width: 50, alignment: .leading)
                        Text(value(for: detail))
                            .frame(width: 100, alignment: .trailing)
                    }
                    .padding(.vertical, 2)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 8).fill(Color.gray.opacity(0.2)))
    }
}

struct CompareWeatherDetailView: View {
    @ObservedObject var viewModel: CompareWeatherDetailViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var selectedMetric: WeatherMetric = .temperature

    var body: some View {
        VStack {
            ScrollView(.horizontal) {
                HStack {
                    Picker("Select Metric", selection: $selectedMetric) {
                        ForEach(WeatherMetric.allCases) { metric in
                            Text(metric.rawValue).tag(metric)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                .frame(height: 40) // Reducimos el tamaño
                .padding(.horizontal)
            }
            ScrollView(.vertical) {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(alignment: .top, spacing: 16) {
                        ForEach(viewModel.weathersDaily) { daily in
                            WeatherColumnView(weatherDaily: daily, selectedMetric: selectedMetric)
                        }
                    }
                    .padding()
                }
            }
            Spacer()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Text("Close")
                }
            }
        }
    }
}
