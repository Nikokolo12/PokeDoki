//
//  SectionModel.swift
//  PokeDoki
//
//  Created by Soto Nicole on 22.02.24.
//

import Foundation
import UIKit

struct PokemonListInfo: Codable {
    let count: Int
    let results: [PokemonSection]
}

struct PokemonSection: Codable, Hashable {
    let name: String
    var url: String
    
    let id = UUID()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    static func == (lhs: PokemonSection, rhs: PokemonSection) -> Bool {
        return lhs.id == rhs.id
    }
}


