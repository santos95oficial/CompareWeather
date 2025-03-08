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

    func openMap()
    func searchPlace()
}

public final class PresentationViewModel: ObservableObject, PresentationViewModelType {

    @Published var userSearchInput: String = ""

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

    func openMap() {
        /*navigationController?.pushViewController(
            UIHostingController(
                rootView: MapSelectionView(viewModel: MapSelectionViewModel())
            ),
            animated: false
        )*/
    }

    func searchPlace() {
        
    }
}
