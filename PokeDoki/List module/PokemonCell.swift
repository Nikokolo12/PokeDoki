//
//  PokemonCell.swift
//  PokeDoki
//
//  Created by Soto Nicole on 21.02.24.
//

import UIKit

class PokemonCell: UITableViewCell {
    static let identifier = "cell"
    var nameLabel: UILabel = {
        var label = UILabel()
        label.text = "Pokemon"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(nameLabel)
        NSLayoutConstraint.activate([
                    nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
                    nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                    nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
                    nameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
                ])

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
