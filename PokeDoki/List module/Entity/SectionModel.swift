//
//  SectionModel.swift
//  PokeDoki
//
//  Created by Soto Nicole on 24.02.24.
//

import Foundation
import UIKit

struct PokemonListInfo: Codable {
    let count: Int
    let results: [PokemonSection]
}

struct PokemonSection: Codable {
    let name: String
}


