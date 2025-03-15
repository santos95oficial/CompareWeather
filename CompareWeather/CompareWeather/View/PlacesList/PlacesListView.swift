import SwiftUI
import MapKit

struct PlacesListView: View {
    
    enum PlacesListViewNavigation: Identifiable {
        case toCompareWeather(place: Place)
        
        var id: String {
            switch self {
            case .toCompareWeather(let place):
                return place.id.uuidString
            }
        }
    }
    
    @StateObject var viewModel: PlacesListViewModel
    @State private var selectedScreen: PlacesListViewNavigation?
    
    var body: some View {
        ZStack {
            WeatherBackgroundView()
            VStack {
                Text(viewModel.titleText)
                    .font(WeatherSize.enormous.size)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(WeatherColor.secondary.color)
                    .padding()
                
                if viewModel.isLoading {
                    ProgressView(viewModel.loadingText)
                        .padding()
                } else {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.places) { place in
                                placeItemView(place: place)
                                    .onTapGesture {
                                        selectedScreen = .toCompareWeather(place: place)
                                    }
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
                viewModel.fetchPlaces()
            }
            .fullScreenCover(item: $selectedScreen) { screen in
                NavigationStack {
                    switch screen {
                    case .toCompareWeather(let place):
                        CompareWeatherView(viewModel: .init(place: place))
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    private func placeItemView(place: Place) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(place.name)
                .font(WeatherSize.medium.size)
                .foregroundColor(WeatherColor.primary.color)

            Text(place.display_name)
                .font(WeatherSize.smallPlus.size)
                .foregroundColor(WeatherColor.primaryLight.color)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(WeatherColor.secondary.color) // Efecto translúcido
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 3)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(WeatherColor.primary.color, lineWidth: 2)
        )
    }
}

#Preview {
    PlacesListView(viewModel: .init(place: "Valladolid"))
}
