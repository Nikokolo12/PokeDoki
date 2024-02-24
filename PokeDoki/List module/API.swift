//
//  APICaller.swift
//  PokeDoki
//
//  Created by Soto Nicole on 24.02.24.
//

import Foundation

protocol APICallerProtocol: class {
    var baseURL: String { get }
    func openUrl(with urlString: String)
}

class APICaller{
    
    var baseURL = "https://pokeapi.co/api/v2/pokemon"
    private var offset = 0
    private var limit = 6
    var isPaginating = false
    
    func fetchPokeData(pagination: Bool, completion: @escaping (Result<[PokemonSection], APIErrors>) -> Void){
        if (pagination) {
            isPaginating = true
        }
        do{
            let url = try modifyURL()
            var someData: [PokemonSection] = []
                
                let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                    guard let data = data, error == nil else {
                        completion(.failure(.noData))
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
                        completion(.failure(.decodingError))
                    }
                }
                
                task.resume()
        }
        catch {
            completion(.failure(.invalidURL))
        }
    }
    
    func modifyURL() throws -> URL{
        guard URL(string: baseURL) != nil else { throw APIErrors.invalidURL }
        if offset >= Constants.numPokemons { throw APIErrors.invalidOffset }
        guard var components = URLComponents(string: baseURL) else { throw APIErrors.invalidURL}
        components.queryItems = [
            URLQueryItem(name: "offset", value: "\(offset)"),
            URLQueryItem(name: "limit", value: "\(limit)")
        ]
        offset += 6
        guard let newURL = components.url else {
            throw APIErrors.invalidURL
        }
        return newURL
    }
}
