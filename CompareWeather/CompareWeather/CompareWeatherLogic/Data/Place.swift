//
//  Place.swift
//  CompareWeather
//
//  Created by Santos Ángel Pardo Ramos on 10/3/25.
//

import Foundation

struct Place: Codable, Identifiable {
    let id = UUID() // Para hacer la estructura Identifiable en SwiftUI
    let name: String
    let lat: String
    let lon: String
    let display_name: String
}
