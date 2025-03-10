//
//  CompareWeatherApp.swift
//  CompareWeather
//
//  Created by Santos Ángel Pardo Ramos on 2/2/25.
//

import SwiftUI

@main
struct CompareWeatherApp: App {
    var body: some Scene {
        WindowGroup {
            PresentationView(viewModel: .init())
        }
    }
}
