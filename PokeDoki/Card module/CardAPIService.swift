//
//  APIService.swift
//  PokeDoki
//
//  Created by Soto Nicole on 23.02.24.
//

import Foundation
import UIKit

protocol CardAPIServiceProtocol {
//index
    func sendData(num: Int, completion: @escaping (Result<pokeInfo, APIErrors>) -> Void)
}

class CardAPIService: CardAPIServiceProtocol{
    
    private var index = 0
    var url: String {
        return "https://pokeapi.co/api/v2/pokemon/\(index)/"
    }
    private var types: [String]? = []
    private var weight: Double?
    private var height: Double?
    private var image: UIImage?
    
    func sendData(num: Int, completion: @escaping (Result<pokeInfo, APIErrors>) -> Void) {
        self.index = num
        request { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                let tuple: pokeInfo = (self.weight!, self.height!, self.types!, self.image!)
                completion(.success(tuple))
            case .failure(let error):
                print("Error: \(error)")
                completion(.failure(.noData))
            }
        }
    }
    
    func request(completionHandler: @escaping (Result<Void, APIErrors>) -> Void) {
        guard let url = URL(string: url) else {
            completionHandler(.failure(.invalidURL))
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(.failure(.noData))
                return
            }
            do {
                let pokeData = try? JSONDecoder().decode(CardPokemonModel.self, from: data)
                self.types = pokeData?.types.map { $0.type.name }
                self.weight = Double(pokeData!.weight)
                self.height = Double(pokeData!.height)
                
                if let imageURL = URL(string: (pokeData?.sprites.frontDefault)!),
                   let imageData = try? Data(contentsOf: imageURL),
                   let image = UIImage(data: imageData){
                    self.image = image
                    completionHandler(.success(()))
                }
            }
        }
        task.resume()
    }
}
