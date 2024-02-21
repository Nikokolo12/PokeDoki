//
//  ViewController.swift
//  PokeDoki
//
//  Created by Soto Nicole on 21.02.24.
//

import UIKit

class ViewController: UIViewController {
    
    //let data = ["Bulbasaur", "Charmander", "Squirtle", "Pikachu", "Jigglypuff"]
    var data: [PokemonSection] = []
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    lazy var dataSource = createDiffableDataSource(tableView)
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
        tableView.register(PokemonCell.self, forCellReuseIdentifier: PokemonCell.identifier)
        tableView.delegate = self
        tableView.dataSource = dataSource
        view.addSubview(tableView)
        applySnapshot()
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func createDiffableDataSource(_ tableView: UITableView) -> UITableViewDiffableDataSource<ViewControllerSection, PokemonSection> {
        let dataSource = UITableViewDiffableDataSource<ViewControllerSection, PokemonSection>(tableView: tableView) { tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonCell.identifier, for: indexPath) as? PokemonCell else { return UITableViewCell() }
            let pokemon = self.data[indexPath.row]
            cell.nameLabel.text = pokemon.name
            return cell
        }
        return dataSource
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<ViewControllerSection, PokemonSection>()
        snapshot.appendSections([.main])
        snapshot.appendItems(data, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension ViewController: UITableViewDelegate{
    
}
