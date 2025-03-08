//
//  MapSelectionViewModel.swift
//  CompareWeather
//
//  Created by Santos Ángel Pardo Ramos on 13/2/25.
//

import Foundation

protocol MapSelectionViewModelType {
    var searchForecastText: String { get }
    var coordinateInfo: String { get }
    var close: String { get }
}

public final class MapSelectionViewModel: ObservableObject, MapSelectionViewModelType {
    var searchForecastText: String = "Buscar predicción"
    var coordinateInfo: String = "📍 Coordenadas: %@ - %@"
    var close: String = "Cerrar"
}
