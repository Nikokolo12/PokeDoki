//
//  Error.swift
//  PokeDoki
//
//  Created by Soto Nicole on 23.02.24.
//

import Foundation

enum APIErrors: Error{
    case invalidURL
    case noData
    case decodingError
    case invalidOffset
    case failedToSaveData
}

