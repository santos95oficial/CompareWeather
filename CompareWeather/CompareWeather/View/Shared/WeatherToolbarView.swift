//
//  WeatherToolbarView.swift
//  CompareWeather
//
//  Created by Santos Ángel Pardo Ramos on 15/3/25.
//

import SwiftUI

struct WeatherToolbarView: View {

    @Environment(\.dismiss) private var dismiss
    private let close = "Volver"

    var body: some View {
        VStack {
            // Your main content here
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Text(close)
                        .font(WeatherSize.medium.size)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .foregroundColor(WeatherColor.secondary.color)
                        .padding()
                }
            }
        }
    }
}
