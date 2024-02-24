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

class CardViewController: UIViewController {

    private var cardAPICaller = CardAPIService()
    private var name = "Pokemon"
    private var type: [String] = ["Pokemon"]
    private var weight = 0.0
    private var height = 0.0
    private var image: UIImage?
    
    private var pokeImageView: UIImageView = {
        var image = UIImage(named: "Question")!
        var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 180, height: 180))
        imageView.image = image
        return imageView
    }()
    private var nameLabel = BaseLabel()
    private var typeLabel = BaseLabel()
    private var weightLabel = BaseLabel()
    private var heightLabel = BaseLabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Go back", style: .plain, target: self, action: #selector(dismissSelf))
        
        view.backgroundColor = .white
        self.title = "Pokemon"
        
        let xCoord = (view.bounds.width - pokeImageView.bounds.width) / 2
        pokeImageView.frame = CGRect(x: xCoord, y: 90, width: pokeImageView.bounds.width + 20, height: pokeImageView.bounds.height + 20)
        
        putComponents()
        
    }
    
    @objc private func dismissSelf(){
        dismiss(animated: true, completion: nil)
    }
    
    func putComponents() {
        nameLabel.frame = CGRect(x: 20, y: pokeImageView.frame.maxY + 20, width: view.bounds.width - 40, height: 30)
        nameLabel.textAlignment = .center
        nameLabel.text = "\(name.uppercased())"
        nameLabel.font = UIFont(name: "Thonburi-Bold", size: 25)
        typeLabel.frame = CGRect(x: 20, y: nameLabel.frame.maxY + 20, width: view.bounds.width - 40, height: 30)
        typeLabel.textAlignment = .center
        typeLabel.text = type.joined(separator: ", ")
        typeLabel.textColor = .red
        weightLabel.frame = CGRect(x: 20, y: typeLabel.frame.maxY + 20, width: 150, height: 30)
        weightLabel.text = "Weight: \(weight) kg"
        heightLabel.frame = CGRect(x: 20, y: weightLabel.frame.maxY + 20, width: 150, height: 30)
        heightLabel.text = "Height: \(height) cm"
        pokeImageView.image = image
        
        view.addSubview(pokeImageView)
        view.addSubview(nameLabel)
        view.addSubview(typeLabel)
        view.addSubview(weightLabel)
        view.addSubview(heightLabel)
    }
}

extension CardViewController: PokeInfo {
    func sendData(name: String, num: Int) {
        self.name = name
        cardAPICaller.sendData(num: num) { [weak self] result in
            switch result{
            case .success(let data):
                DispatchQueue.main.async {
                    guard let self = self else {return }
                    self.weight = Double(data.weight/10)
                    self.height = Double(data.height*10)
                    self.image = data.image
                    self.type = data.types
                    
                    self.putComponents()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
}
