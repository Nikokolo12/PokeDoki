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
        label.text = "Pokemob"
        return label
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
struct PokemonSection: Hashable{
    let name: String
    let id = UUID()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
    
    static func == (lhs: PokemonSection, rhs: PokemonSection) -> Bool {
        return lhs.id == rhs.id
    }
}
