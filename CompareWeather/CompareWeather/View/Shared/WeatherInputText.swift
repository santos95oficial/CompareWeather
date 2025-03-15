//
//  WeatherInputText.swift
//  CompareWeather
//
//  Created by Santos Ángel Pardo Ramos on 15/3/25.
//

import SwiftUI

struct WeatherInputText: View {
    @Binding var userSearchInput: String
    var searchInputText: String

    var body: some View {
        TextField(searchInputText, text: $userSearchInput)
            .textFieldStyle(PlainTextFieldStyle())
            .font(WeatherSize.medium.size)
            .fontWeight(.medium)
            .padding()
            .background(WeatherColor.secondary.color)
            .cornerRadius(10)
            .shadow(radius: 5)
    }
}
