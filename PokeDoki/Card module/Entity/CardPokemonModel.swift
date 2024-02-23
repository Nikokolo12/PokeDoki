//
//  CardPokemonModel.swift
//  PokeDoki
//
//  Created by Soto Nicole on 23.02.24.
//

import Foundation

struct CardPokemonModel: Codable {
    let sprites: Sprites
    let height: Int
    let types: [TypeElement]
    let weight: Int
}

struct Sprites: Codable {
    let frontDefault: String

    enum CodingKeys: String, CodingKey {
        case frontDefault = "front_default"
    }
}

struct TypeElement: Codable {
    let type: TypeType
}

struct TypeType: Codable {
    let name: String
}
