//
//  CompareWeatherView.swift
//  CompareWeather
//
//  Created by Santos Ángel Pardo Ramos on 5/2/25.
//

import SwiftUI
import MapKit

struct CompareWeatherView: View {
    @StateObject var viewModel: CompareWeatherViewModel

    var body: some View {
        Text(viewModel.name)
    }
}
