//
//  ViewController.swift
//  PokeDoki
//
//  Created by Soto Nicole on 21.02.24.
//

import UIKit

class ViewController: UIViewController {

    //let data = ["Bulbasaur", "Charmander", "Squirtle", "Pikachu", "Jigglypuff"]
    lazy var dataSource = createDiffableDataSource()
    var data: [PokemonSection] = []
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        return tableView
    }()

    enum ViewControllerSection: Hashable{
        case main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pokemon1 = PokemonSection.init(name: "Bulbasaur")
        let pokemon2 = PokemonSection.init(name: "Charmander")
        let pokemon3 = PokemonSection.init(name: "Squirtle")
        let pokemon4 = PokemonSection.init(name: "Pikachu")
        data = [pokemon1, pokemon2, pokemon3, pokemon4]
        
        tableView.register(UINib(nibName: "PokemonSection", bundle: nil), forCellReuseIdentifier: PokemonCell.identifier)
        tableView.delegate = self
        
        view.addSubview(tableView)
        applySnapshot()
    }
    
    private func createDiffableDataSource() -> UITableViewDiffableDataSource<ViewControllerSection, PokemonSection>{
        let dataSource = UITableViewDiffableDataSource<ViewControllerSection, PokemonSection>(tableView: tableView) {tableView, indexPath, model in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonCell.identifier) as? PokemonCell else { return UITableViewCell() }
            
            return cell
        }
        return dataSource
    }
    
    func applySnapshot(){
        var snapshot = NSDiffableDataSourceSnapshot<ViewControllerSection, PokemonSection>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

extension ViewController: UITableViewDelegate{
    
}
