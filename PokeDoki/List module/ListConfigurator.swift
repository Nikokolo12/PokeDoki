//
//  ListConfigurator.swift
//  PokeDoki
//
//  Created by Soto Nicole on 24.02.24.
//

import Foundation

protocol ListConfiguratorProtocol{
    func configure(viewController: ViewController)
}

class ListConfigurator: ListConfiguratorProtocol{
    func configure(viewController: ViewController) {
        let presenter = ListPresenter(view: viewController)
        let apiCaller = APICaller()
        let interactor = ListInteractor(presenter: presenter, apiService: apiCaller )
        let router = ListRouter(viewController: viewController)
        
        viewController.presenter = presenter
        presenter.interactor = interactor
        presenter.router = router
    }
    
    
}
