//
//  ListInteractor.swift
//  PokeDoki
//
//  Created by Soto Nicole on 24.02.24.
//

import Foundation
import UIKit
import CoreData

protocol ListInteractorProtocol {
    var urlSource: String { get }
    func openUrl (completion: @escaping ([String]) -> Void)
    var apiService: APICallerProtocol { get set }
}

class ListInteractor: ListInteractorProtocol{
    var counter = 0
    var modelListPokemon: [ListPokemon] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var apiService: APICallerProtocol
    weak var presenter: ListPresenterProtocol?
    var urlSource: String {
        get {
            apiService.baseURL
        }
    }
    
    required init(presenter: ListPresenterProtocol, apiService: APICallerProtocol) {
        self.presenter = presenter
        self.apiService = apiService
    }
    
    func createListPokemon(name: String, index: Int64){
        let newListPokemon = ListPokemon(context: context)
        newListPokemon.index = index
        newListPokemon.name = name
        do {
            try context.save()
        } catch(let error){
            print("The error: \(error)")
        }
    }

    
    func openUrl(completion: @escaping ([String]) -> Void) {
        apiService.fetchPokeData(pagination: false) { result in
            switch result {
            case .success(let someData):
                let names = someData.map(\.name)
                completion(names)
            case .failure(let error):
                print("Error with fetching: \(error)")
                completion([])
            }
        }
    }
    
}

