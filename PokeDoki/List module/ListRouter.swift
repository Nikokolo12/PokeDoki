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
    weak var viewController: ViewController!
    var delegate: PokeInfo?
    init(viewController: ViewController) {
        self.viewController = viewController
    }
    
    func closeCurrentViewController(name: String, num: Int) {
        
        let cardViewController = CardViewController()
        let navigationController = UINavigationController(rootViewController: cardViewController)
        cardViewController.modalPresentationStyle = .fullScreen
        
        delegate = cardViewController.presenter as? PokeInfo
        delegate?.sendData(name: name, num: num)
        viewController.dismiss(animated: true, completion: nil)
        navigationController.pushViewController(cardViewController,animated: true)
    }
}
