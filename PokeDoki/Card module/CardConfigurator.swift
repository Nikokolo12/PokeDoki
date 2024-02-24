//
//  CardConfigurator.swift
//  PokeDoki
//
//  Created by Soto Nicole on 24.02.24.
//

import Foundation

protocol CardConfiguratorProtocol: AnyObject {
    func configure(viewController: CardViewController)
}

class CardConfigurator: CardConfiguratorProtocol {
    
    func configure(viewController: CardViewController) {
        let presenter = CardPresenter(view: viewController)
        let interactor = CardInteractor(presenter: presenter)
        let router = CardRouter(viewController: viewController)
        
        viewController.presenter = presenter
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
}
