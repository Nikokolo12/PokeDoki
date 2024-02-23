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

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
