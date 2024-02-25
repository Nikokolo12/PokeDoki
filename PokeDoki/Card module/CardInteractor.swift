//
//  CardInteractor.swift
//  PokeDoki
//
//  Created by Soto Nicole on 24.02.24.
//

import Foundation
import UIKit
import CoreData

protocol CardInteractorProtocol{
    var modelPokemonItem: [PokemonItem] {get set}
    func openUrl(num: Int, completion: @escaping (pokeInfo) -> Void)
    func getPokemonItem(num: Int, completion: @escaping (pokeInfo) -> Void)
}

class CardInteractor: CardInteractorProtocol {
    var modelPokemonItem: [PokemonItem] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var presenter: CardPresenterProtocol?
    let apiService: CardAPIServiceProtocol = CardAPIService()
    
    required init(presenter: CardPresenterProtocol) {
        self.presenter = presenter
    }
    
    func getPokemonItem(num: Int, completion: @escaping (pokeInfo) -> Void) {
        do {
            modelPokemonItem = try context.fetch(PokemonItem.fetchRequest())
            if let pokemonItem = modelPokemonItem.first(where: { $0.index == Int64(num) }) {
                let pokeInfo = convertToPokeInfo(pokemonItem: pokemonItem)
                completion(pokeInfo)
            } else {
                openUrl(num: num) { result in
                    completion(result)
                }
            }
        } catch {
            print("Error fetching PokemonItem from CoreData: \(error)")
        }
    }
    
    func createPokemonItem(tuple: pokeInfo, index: Int64) {
        let newPokemonItem = PokemonItem(context: context)
        newPokemonItem.weight = tuple.weight
        newPokemonItem.height = tuple.height
        newPokemonItem.index = index
        newPokemonItem.image = tuple.image.pngData()
        newPokemonItem.types = tuple.types as NSObject
        do {
            try context.save()
        } catch(let error){
            print("The error: \(error)")
        }
    }
    
    func convertToPokeInfo(pokemonItem: PokemonItem) -> pokeInfo {
        let weight: Double = pokemonItem.weight
        let height: Double = pokemonItem.height
        let image = UIImage(data: pokemonItem.image ?? Data()) ?? UIImage()
        let types = pokemonItem.types as? [String] ?? []
        
        return (weight, height, types, image)
    }
    
    func openUrl(num: Int, completion: @escaping (pokeInfo) -> Void) {
        apiService.sendData(num: num) { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.createPokemonItem(tuple: (data.weight, data.height, data.types, data.image), index: Int64(exactly: num)!)
                    completion((data.weight, data.height, data.types, data.image))
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

