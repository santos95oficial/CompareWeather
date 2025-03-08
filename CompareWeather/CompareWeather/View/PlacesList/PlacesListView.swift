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
    @Environment(\.dismiss) private var dismiss
    @State private var selectedScreen: PlacesListViewNavigation?

    var body: some View {
        VStack {
            Text(viewModel.titleText)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .padding(.top)

            if viewModel.isLoading {
                ProgressView(viewModel.loadingText)
                    .padding()
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(viewModel.places) { place in
                            placeItemView(place: place)
                                .onTapGesture {
                                    viewModel.placeSelected(place)
                                    selectedScreen = .toCompareWeather(place: place)
                                }
                        }
                    }
                    .padding()
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(viewModel.close) {
                    dismiss()
                }
            }
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

    @ViewBuilder
    private func placeItemView(place: Place) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(place.name)
                .font(.headline)
                .foregroundColor(.primary)

            Text(place.display_name)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(.ultraThinMaterial) // Efecto translúcido
        .cornerRadius(12)
        .shadow(color: .gray.opacity(0.3), radius: 5, x: 0, y: 3)
    }
}

#Preview {
    PlacesListView(viewModel: .init(place: "Valladolid"))
}
