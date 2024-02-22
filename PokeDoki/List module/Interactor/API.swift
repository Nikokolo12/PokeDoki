//
//  API.swift
//  PokeDoki
//
//  Created by Soto Nicole on 22.02.24.
//

import Foundation

class APICaller{
    let apiUrl = "https://pokeapi.co/api/v2/pokemon"
    var curentIndex : Int = 0
    var numberArray = Array(1...42)
    var fetchingMore = false
    var isPaginating: Bool = false
    
    func fetchPokeData(pagination: Bool, completion: @escaping (Result<[PokemonSection], Error>) -> Void){
        if (pagination) {
            isPaginating = true
        }
        guard let url = URL(string: apiUrl) else {
            print("Invalid URL")
            return
        }
        var someData: [PokemonSection] = []
        var newData: [PokemonSection] = [PokemonSection(name: "Pikachu")]
        DispatchQueue.global().asyncAfter(deadline: .now() + 1) { [self] in
            
            let task = URLSession.shared.dataTask(with: url) { [weak self] (data, response, error) in
                guard let data = data, error == nil else {
                    print("Error: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }
                do {
                    let pokemonList = try JSONDecoder().decode(PokemonListInfo.self, from: data)
                    someData = pokemonList.results
//                    if let next = pokemonList.next {
//                        newData =
//                    }
                    completion(.success(pagination ? newData : someData))
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
    
}


