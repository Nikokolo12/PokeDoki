//
//  ViewController.swift
//  PokeDoki
//
//  Created by Soto Nicole on 21.02.24.
//

import UIKit

class ViewController: UIViewController {
    var pokemons: [PokemonSection] = []
    private let apiCaller = APICaller()
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        apiCaller.fetchPokeData(pagination: false){ [weak self] result in
            switch result {
            case .success(let someData):
                self?.pokemons.append(contentsOf: someData)
                DispatchQueue.main.async {
                    self?.applySnapshot()
                }
            case .failure(_):
                print("Error with fetching")
            }
        }
    }
    
    private func createDiffableDataSource(_ tableView: UITableView) -> UITableViewDiffableDataSource<ViewControllerSection, PokemonSection> {
        let dataSource = UITableViewDiffableDataSource<ViewControllerSection, PokemonSection>(tableView: tableView) { tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonCell.identifier, for: indexPath) as? PokemonCell else { return UITableViewCell() }
            let pokemon = self.pokemons[indexPath.row]
            cell.nameLabel.text = pokemon.name
            return cell
        }
        return dataSource
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<ViewControllerSection, PokemonSection>()
        snapshot.appendSections([.main])
        snapshot.appendItems(pokemons, toSection: .main)
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    private func createLoadingSpinerFooter() -> UIView?{
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spiner = UIActivityIndicatorView(style: .large)
        spiner.center = view.center
        footerView.addSubview(spiner)
        spiner.startAnimating()
        return footerView
    }
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected \(pokemons[indexPath.row])")
    }
    
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if (position > self.tableView.contentSize.height - scrollView.frame.size.height - 20) {
            guard !apiCaller.isPaginating else { return }
            self.tableView.tableFooterView = createLoadingSpinerFooter()

            apiCaller.fetchPokeData(pagination: true) { [weak self] result in
                DispatchQueue.main.async {
                    self?.tableView.tableFooterView = nil
                }
                switch result {
                case .success(let newData):
                    self?.pokemons.append(contentsOf: newData)
                    DispatchQueue.main.async {
                        self?.applySnapshot()
                    }
                case .failure(_):
                    print("Error with fetching")
                }
            }
        }
    }
}
