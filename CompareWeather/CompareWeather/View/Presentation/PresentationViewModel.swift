//
//  PresentationViewModel.swift
//  CompareWeather
//
//  Created by Santos Ángel Pardo Ramos on 4/2/25.
//

import Foundation
import SwiftUI

protocol PresentationViewModelType {
    var title: String { get }
    var searchInputText: String { get }
    var searchButtonText: String { get }
    var openMapButtonText: String { get }
    var userSearchInput: String { get set }

    func search()
    func openMap()
}

enum Destination: Hashable {
    case searchPlace(userText: String)
    case openMap
}

final class PresentationViewModel: ObservableObject, PresentationViewModelType {

    @Published var userSearchInput: String = ""
    @Published var navigationPath = NavigationPath() // ✅ Nueva forma de manejar la navegación

    var title: String {
        "Compare Weather"
    }

    var searchInputText: String {
        "Introduce un lugar o una ciudad para buscar"
    }
    var searchButtonText: String {
        "Buscar"
    }
    var openMapButtonText: String {
        "Abrir mapa"
    }

    func search() {
        guard !userSearchInput.isEmpty else { return }
        navigationPath.append(Destination.searchPlace(userText: userSearchInput)) // ✅ Empujar destino
    }

    func openMap() {
        navigationPath.append(Destination.openMap) // ✅ Empujar destino
    }
}
