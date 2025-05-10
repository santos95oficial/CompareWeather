//
//  MapSelectionViewModel.swift
//  CompareWeather
//
//  Created by Santos Ángel Pardo Ramos on 13/2/25.
//

import Foundation
import MapKit

protocol MapSelectionViewModelType {
    var searchForecastText: String { get }
    var coordinateInfo: String { get }
    var close: String { get }
    var selectedLocation: CLLocationCoordinate2D? { get }
}

public final class MapSelectionViewModel: ObservableObject, MapSelectionViewModelType {

    @Published var selectedLocation: CLLocationCoordinate2D?

    var searchForecastText: String = "Buscar predicción"
    var coordinateInfo: String {
        String(format: "📍 Coordenadas: %.3f - %.3f", selectedLocation?.latitude ?? "", selectedLocation?.longitude ?? "")
    }
    var close: String = "Cerrar"
}
