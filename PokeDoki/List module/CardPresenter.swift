//
//  CardPresenter.swift
//  PokeDoki
//
//  Created by Soto Nicole on 24.02.24.
//

import Foundation
import UIKit

protocol CardPresenterProtocol: AnyObject{
    var router: CardRouterProtocol? {get set}
    func configureCardView()
    func closeButtonClicked()
    func sendData(name: String, num: Int)
}

class CardPresenter: CardPresenterProtocol{
    private var name = "Pokemon"
    private var pokemonData: pokeInfo = (0.0, 0.0, [], UIImage(named: "Question")!)
    
    weak var view: CardViewProtocol?
    var router: CardRouterProtocol?
    var interactor: CardInteractorProtocol?
    
    required init(view: CardViewProtocol) {
        self.view = view
    }
    
    func closeButtonClicked() {
        router?.closeCurrentViewController()
    }
    
    func configureCardView() {
        view?.configureComponents(tuple: self.pokemonData, name: self.name)
    }
    
    func sendData(name: String, num: Int) {
        self.name = name
        interactor?.getPokemonItem(num: num, completion: { data in
            self.pokemonData = data
            self.pokemonData.0 /= Constants.pokeWeight
            self.pokemonData.1 *= Constants.pokeHeight
            self.configureCardView()
        })
    }
}
