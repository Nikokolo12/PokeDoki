//
//  CardViewController.swift
//  PokeDoki
//
//  Created by Soto Nicole on 23.02.24.
//

import UIKit

class CardViewController: UIViewController {
    
    var pokeImageView: UIImageView = {
        var image = UIImage(named: "Question")!
        var imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 180, height: 180))
        imageView.image = image
        return imageView
    }()
    
    var nameLabel: UILabel = {
        var label = UILabel()
        label.text = "Pokemon"
        return label
    }()
    var typeLabel: UILabel = {
        var label = UILabel()
        label.text = "Pokemon"
        return label
    }()
    var weightLabel: UILabel = {
        var label = UILabel()
        label.text = "Pokemon"
        return label
    }()
    var heightLabel: UILabel = {
        var label = UILabel()
        label.text = "Pokemon"
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let xCoord = (view.bounds.width - pokeImageView.bounds.width) / 2
        pokeImageView.frame = CGRect(x: xCoord, y: 90, width: pokeImageView.bounds.width + 20, height: pokeImageView.bounds.height + 20)
        addRainbowBorder(to: pokeImageView)
        view.addSubview(pokeImageView)
        
        putLabels()
        
    }
    
    func putLabels() {
        nameLabel.frame = CGRect(x: 20, y: pokeImageView.frame.maxY + 20, width: view.bounds.width - 40, height: 30)
        nameLabel.textAlignment = .center
        typeLabel.frame = CGRect(x: 20, y: nameLabel.frame.maxY + 20, width: view.bounds.width - 40, height: 30)
        typeLabel.textAlignment = .center
        weightLabel.frame = CGRect(x: 20, y: typeLabel.frame.maxY + 20, width: 150, height: 30)
        heightLabel.frame = CGRect(x: 20, y: weightLabel.frame.maxY + 20, width: 150, height: 30)
        
        view.addSubview(nameLabel)
        view.addSubview(typeLabel)
        view.addSubview(weightLabel)
        view.addSubview(heightLabel)
    }
    
    func addRainbowBorder(to view: UIView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [
            UIColor.red.cgColor,
            UIColor.orange.cgColor,
            UIColor.yellow.cgColor,
            UIColor.green.cgColor,
            UIColor.blue.cgColor,
            UIColor.purple.cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        gradientLayer.cornerRadius = view.layer.cornerRadius
        gradientLayer.borderWidth = 2.0

        view.layer.addSublayer(gradientLayer)
        view.layer.masksToBounds = true
        view.layer.insertSublayer(view.layer.sublayers?.first ?? CALayer(), above: gradientLayer)
    }
}
