//
//  CardInteractor.swift
//  PokeDoki
//
//  Created by Soto Nicole on 24.02.24.
//

import Foundation
import UIKit

protocol CardInteractorProtocol{

    func openUrl(num: Int, completion: @escaping (pokeInfo) -> Void)
}

class CardInteractor: CardInteractorProtocol{
    
    var presenter: CardPresenterProtocol!
    
    let apiService: CardAPIServiceProtocol = CardAPIService()
    
    required init(presenter: CardPresenterProtocol) {
        self.presenter = presenter
    }
    
    func openUrl(num: Int, completion: @escaping (pokeInfo) -> Void) {
        apiService.sendData(num: num) { [weak self] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {

                    let weight: Double = data.weight
                    let height: Double = data.height
                    let image: UIImage = data.image
                    let type: [String] = data.types

                    completion((weight, height, type, image))
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

