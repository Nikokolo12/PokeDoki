//
//  API.swift
//  PokeDoki
//
//  Created by Soto Nicole on 22.02.24.
//

import Foundation

class APICaller{
    // private let apiUrl = "https://pokeapi.co/api/v2/pokemon?offset=0&limit=40"
    private var baseURL = "https://pokeapi.co/api/v2/pokemon"
    private var offset = 0
    private var limit = 6
    var isPaginating = false
    
    func fetchPokeData(pagination: Bool, completion: @escaping (Result<[PokemonSection], Error>) -> Void){
        if (pagination) {
            isPaginating = true
        }
        
        let url = modifyURL()
        var someData: [PokemonSection] = []

        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [self] in

            let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard let data = data, error == nil else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                do {
                    let pokemonList = try JSONDecoder().decode(PokemonListInfo.self, from: data)
                    someData = pokemonList.results

                    completion(.success(someData))
                    if (pagination) {
                        self?.isPaginating = false
                    }
                } catch {
                    print("Error decoding data: \(error.localizedDescription)")
                }
            }

            task.resume()
        }
    }
    
    func modifyURL() -> URL{
        guard URL(string: baseURL) != nil else {fatalError("Failed to construct URL")}
        if offset >= 1302 { fatalError("Failed to construct URL")}
        guard var components = URLComponents(string: baseURL) else{ fatalError("Failed to construct URL") }
        components.queryItems = [
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "limit", value: "\(limit)")
        ]
        offset += 20
        guard let newURL = components.url else {
            fatalError("Failed to construct URL")
        }
        return newURL
    }
}

