//
//  ListRouter.swift
//  PokeDoki
//
//  Created by Soto Nicole on 24.02.24.
//

import Foundation

protocol ListRouterProtocol{
    func closeCurrentViewController()
}

class ListRouter: ListRouterProtocol{
    weak var viewController: ViewController!
    
    init(viewController: ViewController) {
        self.viewController = viewController
    }
    
    func closeCurrentViewController() {
        viewController.dismiss(animated: true, completion: nil)
    }
}
