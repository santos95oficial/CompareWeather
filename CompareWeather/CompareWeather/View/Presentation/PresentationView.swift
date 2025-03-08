//
//  SwiftUIView.swift
//  CompareWeather
//
//  Created by Santos Ángel Pardo Ramos on 4/2/25.
//

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
        VStack(spacing: 20) {
            Spacer()

            Text(viewModel.title)
                .font(.largeTitle)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)

            TextField(viewModel.searchInputText, text: $viewModel.userSearchInput)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .font(.subheadline)
                .fontWeight(.medium)
                .padding()

            Button(action: {
                selectedScreen = .toSearch
            }) {
                Text(viewModel.searchButtonText)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            Button(action: {
                selectedScreen = .toMap
            }) {
                Text(viewModel.openMapButtonText)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)

            Spacer()
        }
        .padding()
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

