//
//  ListRouter.swift
//  PokeDoki
//
//  Created by Soto Nicole on 24.02.24.
//

import Foundation
import UIKit
protocol ListRouterProtocol{
    func closeCurrentViewController(name: String, num: Int)
}

class ListRouter: ListRouterProtocol{
    weak var viewController: ViewController?
    var delegate: CardPresenterProtocol?
    
    init(viewController: ViewController) {
        self.viewController = viewController
    }
    
    func closeCurrentViewController(name: String, num: Int) {
        
        let cardViewController = CardViewController()
        let navigationController = UINavigationController(rootViewController: cardViewController)
        
        navigationController.modalPresentationStyle = .fullScreen
        viewController?.present(navigationController, animated: true, completion: { [weak self] in
                self?.delegate = cardViewController.presenter
                self?.delegate?.sendData(name: name, num: num)
        })
    }
}
