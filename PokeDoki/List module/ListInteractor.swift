//
//  ListInteractor.swift
//  PokeDoki
//
//  Created by Soto Nicole on 24.02.24.
//

import Foundation
import UIKit

protocol ListInteractorProtocol{
    var urlSource: String { get }
    func openUrl(completion: @escaping ([String]) -> Void)
    var apiService: APICallerProtocol { get set }
}

class ListInteractor: ListInteractorProtocol{
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

