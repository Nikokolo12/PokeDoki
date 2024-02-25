//
//  CardViewController.swift
//  PokeDoki
//
//  Created by Soto Nicole on 23.02.24.
//

import UIKit

class BaseLabel: UILabel{
    private func commonInit() {
        self.text = "Pokemon"
    }
}

protocol CardViewProtocol: AnyObject{
    func configureComponents(tuple: pokeInfo, name: String)
}

class CardViewController: UIViewController, CardViewProtocol {

    var presenter: CardPresenterProtocol?
    let configurator = CardConfigurator()
    private var cardAPICaller = CardAPIService()
    
    private var pokeImageView: UIImageView = {
        var image = UIImage(named: "Question")!
        var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 180, height: 180))
        imageView.image = image
        return imageView
    }()
    private let nameLabel = BaseLabel()
    private let typeLabel = BaseLabel()
    private let weightLabel = BaseLabel()
    private let heightLabel = BaseLabel()
    private let activityIndicator: UIActivityIndicatorView = {
        var activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = .large
        
        return activityIndicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(viewController: self)
        
        view.addSubview(activityIndicator)
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Go back", style: .plain, target: self, action: #selector(dismissSelf))
        navigationController?.navigationBar.tintColor = .systemRed
        view.backgroundColor = .white
        self.title = "Pokemon"
        
        let xCoord = (view.bounds.width - pokeImageView.bounds.width) / 2
        pokeImageView.frame = CGRect(x: xCoord, y: 90, width: pokeImageView.bounds.width + 20, height: pokeImageView.bounds.height + 20)
        
    }
    
    @objc private func dismissSelf(){
        presenter?.closeButtonClicked()
    }

    func configureComponents(tuple: pokeInfo, name: String) {
        nameLabel.frame = CGRect(x: 20, y: pokeImageView.frame.maxY + 20, width: view.bounds.width - 40, height: 30)
        nameLabel.textAlignment = .center
        nameLabel.text = "\(name.uppercased())"
        nameLabel.font = UIFont(name: "Thonburi-Bold", size: 25)
        typeLabel.frame = CGRect(x: 20, y: nameLabel.frame.maxY + 20, width: view.bounds.width - 40, height: 30)
        typeLabel.textAlignment = .center
        typeLabel.text = tuple.types.joined(separator: ", ")
        typeLabel.textColor = .red
        weightLabel.frame = CGRect(x: 20, y: typeLabel.frame.maxY + 20, width: 150, height: 30)
        weightLabel.text = "Weight: \(tuple.weight) kg"
        heightLabel.frame = CGRect(x: 20, y: weightLabel.frame.maxY + 20, width: 150, height: 30)
        heightLabel.text = "Height: \(tuple.height) cm"
        pokeImageView.image = tuple.image
        
        view.addSubview(pokeImageView)
        view.addSubview(nameLabel)
        view.addSubview(typeLabel)
        view.addSubview(weightLabel)
        view.addSubview(heightLabel)
        activityIndicator.removeFromSuperview()
    }
}


