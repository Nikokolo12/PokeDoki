//
//  ListPresenter.swift
//  PokeDoki
//
//  Created by Soto Nicole on 24.02.24.
//

import Foundation

protocol ListPresenterProtocol: class{
    var router: ListRouterProtocol! {get set}
    var pokemonNames: [String] {get set}
    func cellClicked(name: String, num: Int)
    func configureView()
}

class ListPresenter: ListPresenterProtocol{
    var pokemonNames: [String] = []
    var router: ListRouterProtocol!
    var interactor: ListInteractorProtocol!
    weak var view: ListViewProtocol!
    
    required init(view: ListViewProtocol) {
            self.view = view
        }
    
    func cellClicked(name: String, num: Int) {
        
        router.closeCurrentViewController(name: name, num: num)
    }
    
    func configureView() {
        interactor.openUrl { names in
            self.pokemonNames.append(contentsOf: names)
            print("the names \(self.pokemonNames)")
        }
        print(self.pokemonNames)
        view.setURLCellTitle(names: self.pokemonNames)
    }
    
}
