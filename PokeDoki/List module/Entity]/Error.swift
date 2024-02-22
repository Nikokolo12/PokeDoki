//
//  Error.swift
//  PokeDoki
//
//  Created by Soto Nicole on 23.02.24.
//

import Foundation
// failed to get data error decoding data Failed to construct URL

enum APIErrors: Error{
    case invalidURL
    case noData
    case decodingError
    case invalidOffset
}
