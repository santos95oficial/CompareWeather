//
//  BackgroundView.swift
//  CompareWeather
//
//  Created by Santos Ángel Pardo Ramos on 15/3/25.
//

import SwiftUI

struct WeatherBackgroundView: View {
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [WeatherColor.primary.color, WeatherColor.secondary.color]), startPoint: .top, endPoint: .bottom)
            .edgesIgnoringSafeArea(.all)
    }
}
