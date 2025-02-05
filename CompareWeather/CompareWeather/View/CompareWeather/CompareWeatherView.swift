//
//  CompareWeatherView.swift
//  CompareWeather
//
//  Created by Santos Ángel Pardo Ramos on 5/2/25.
//

import SwiftUI
import MapKit

struct CompareWeatherView: View {
    let location: CLLocationCoordinate2D

    var body: some View {
        Text("Latitute: \(location.latitude) - Longitute:\(location.longitude)")
    }
}

#Preview {
    CompareWeatherView(location: CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0))
}
