//
//  WeatherButton.swift
//  CompareWeather
//
//  Created by Santos Ángel Pardo Ramos on 15/3/25.
//

import SwiftUI

struct WeatherButton: View {

    enum ButtonType {
        case primary
        case secondary
    }

    var type: ButtonType
    var title: String
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(WeatherSize.medium.size)
                .padding()
                .frame(maxWidth: .infinity)
                .background(buttonBackground(type: type))
                .foregroundColor(buttonTextColor(type: type))
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(buttonBorderColor, lineWidth: 2)
                )
        }
    }
}

private extension WeatherButton {

    func buttonBackground(type: ButtonType) -> Color {
        switch type {
        case .primary:
            return WeatherColor.primary.color
        case .secondary:
            return WeatherColor.secondary.color
        }
    }

    func buttonTextColor(type: ButtonType) -> Color {
        switch type {
        case .primary:
            return WeatherColor.secondary.color
        case .secondary:
            return WeatherColor.primary.color
        }
    }

    var buttonBorderColor: Color {
        WeatherColor.primary.color
    }
}
