import SwiftUI

struct PresentationView: View {

    enum PresentationViewNavigation: Identifiable {
        case toMap
        case toSearch

        var id: Self { self }
    }

    @StateObject var viewModel: PresentationViewModel
    @State private var selectedScreen: PresentationViewNavigation?

    var body: some View {
        ZStack {
            WeatherBackgroundView()

            VStack(spacing: 20) {
                Spacer()

                Text(viewModel.title)
                    .font(WeatherSize.enormous.size)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .foregroundColor(WeatherColor.secondary.color)
                    .padding()

                WeatherInputText(userSearchInput: $viewModel.userSearchInput, searchInputText: viewModel.searchInputText)

                WeatherButton(type: .primary, title: viewModel.searchButtonText) {
                    selectedScreen = .toSearch
                }
                WeatherButton(type: .secondary, title: viewModel.openMapButtonText) {
                    selectedScreen = .toMap
                }
                Spacer()
            }
            .padding()
        }
        .fullScreenCover(item: $selectedScreen) { screen in
            NavigationStack {
                switch screen {
                case .toMap:
                    MapSelectionView()
                case .toSearch:
                    PlacesListView(viewModel: .init(place: viewModel.userSearchInput))
                }
            }
        }
    }
}
