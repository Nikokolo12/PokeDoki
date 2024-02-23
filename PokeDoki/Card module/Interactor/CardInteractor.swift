//
//  CardInteractor.swift
//  PokeDoki
//
//  Created by Soto Nicole on 23.02.24.
//

import Foundation
import UIKit

class CardAPI{
    
    private var index = 1
    private var url: String {
        return "https://pokeapi.co/api/v2/pokemon/\(index)"
    }
    private var types: [String]? = []
    private var weight: Int?
    private var height: Int?
    private var image: UIImage?
    
    func sendData(num: Int, completion: @escaping (Result<(weight: Int, height: Int, types: [String], image: UIImage), APIErrors>) -> Void) {
            self.index = num
            request { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .success:
                    let tuple = (self.weight!, self.height!, self.types!, self.image!)
                    completion(.success(tuple))
                case .failure(let error):
                    print("Error: \(error)")
                    completion(.failure(error))
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
                self.weight = pokeData?.weight
                self.height = pokeData?.height
                
                DispatchQueue.main.async {
                    if let imageURL = URL(string: (pokeData?.sprites.frontDefault)!),
                       let imageData = try? Data(contentsOf: imageURL),
                       let image = UIImage(data: imageData){
                        self.image = image
                    }
                }
            }
        }
        task.resume()
    }
}
