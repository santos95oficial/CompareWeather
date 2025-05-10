//
//  WeatherColor.swift
//  CompareWeather
//
//  Created by Santos Ángel Pardo Ramos on 15/3/25.
//

import Foundation
import SwiftUI

enum WeatherColor {
    case primary
    case primaryLight
    case secondary
    case black

    var color: Color {
        switch self {
        case .primary:
                .blue
        case .primaryLight:
                .blue.opacity(0.5)
        case .secondary:
                .white
        case .black:
                .black
        }
    }
}

enum WeatherSize {
    case small
    case smallPlus
    case medium
    case large
    case extraLarge
    case enormous

    var size: Font {
        switch self {
        case .small:
            return .system(size: 12)
        case .smallPlus:
            return .system(size: 14)
        case .medium:
            return .system(size: 16)
        case .large:
            return .system(size: 20)
        case .extraLarge:
            return .system(size: 24)
        case .enormous:
            return .system(size: 40)
        }
    }
}
