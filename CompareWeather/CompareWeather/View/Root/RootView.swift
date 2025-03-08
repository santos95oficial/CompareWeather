//
//  RootView.swift
//  CompareWeather
//
//  Created by Santos Ángel Pardo Ramos on 13/2/25.
//

import SwiftUI

struct RootView: View {
    

    // MARK: - View

    var body: some View {
        PresentationView(viewModel: .init())
    }
}
