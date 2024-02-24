//
//  ListPresenter.swift
//  PokeDoki
//
//  Created by Soto Nicole on 24.02.24.
//

import Foundation

protocol ListPresenterProtocol: AnyObject{
    var router: ListRouterProtocol? {get set}
    var pokemonNames: [String] {get set}
    func cellClicked(name: String, num: Int)
    func configureView()
    func didScrollView()
}

class ListPresenter: ListPresenterProtocol {
    
    var pokemonNames: [String] = []
    var router: ListRouterProtocol?
    var interactor: ListInteractorProtocol?
    weak var view: ListViewProtocol?
    
    required init(view: ListViewProtocol) {
        self.view = view
    }
    
    func cellClicked(name: String, num: Int) {
        router?.closeCurrentViewController(name: name, num: num)
    }
    
    func configureView() {
        updateData { [weak self] names in
            self?.view?.setURLCellTitle(names: names)
        }
    }
    func didScrollView() {
        updateData { [weak self] names in
            self?.view?.setURLCellTitle(names: names)
        }
    }
    
    private func updateData(completion: @escaping ([String]) -> Void) {
        interactor?.openUrl { names in
            completion(names)
        }
    }
}
