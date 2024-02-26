//
//  CardRouter.swift
//  PokeDoki
//
//  Created by Soto Nicole on 24.02.24.
//

import Foundation

protocol CardRouterProtocol: AnyObject{
    func closeCurrentViewController()
}

class CardRouter: CardRouterProtocol{
    weak var viewController: CardViewController!
    
    init(viewController: CardViewController) {
        self.viewController = viewController
    }
    
    func closeCurrentViewController() {
        viewController.dismiss(animated: true, completion: nil)
    }
    
    
}
