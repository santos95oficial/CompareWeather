//
//  SwiftUIView.swift
//  CompareWeather
//
//  Created by Santos Ángel Pardo Ramos on 4/2/25.
//

import SwiftUI

struct PresentationView: View {
    @StateObject private var viewModel = PresentationViewModel()
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) { // ✅ Usamos navigationPath
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
                    viewModel.search()
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
                    viewModel.openMap()
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
            .navigationDestination(for: Destination.self) { destination in
                switch destination {
                case .searchPlace(let userText):
                    PlacesListView(userText: userText)
                }
            }
        }
    }
}


#Preview {
    PresentationView()
}
