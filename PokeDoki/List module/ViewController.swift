//
//  ViewController.swift
//  PokeDoki
//
//  Created by Soto Nicole on 24.02.24.
//

import UIKit

protocol ListViewProtocol: AnyObject {
    func setURLCellTitle(names: [String])
}

class ViewController: UIViewController, ListViewProtocol {
    
    private var pokemons: [String] = []
    private let apiCaller = APICaller()// TODO: remove
    private var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var presenter: ListPresenterProtocol!
    let configurator = ListConfigurator()
    
    lazy var dataSource = createDiffableDataSource(tableView)
    enum ViewControllerSection: Hashable{
        case main
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.configure(viewController: self)
        presenter.configureView()
        
        tableView.register(PokemonCell.self, forCellReuseIdentifier: PokemonCell.identifier)
        tableView.delegate = self
        tableView.dataSource = dataSource
        view.addSubview(tableView)
        setURLCellTitle(names: pokemons)
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
    }
    
    func setURLCellTitle(names: [String]) {
        pokemons.append(contentsOf: names)
        DispatchQueue.main.async {
            self.applySnapshot()
        }
    }
    
    private func createDiffableDataSource(_ tableView: UITableView) -> UITableViewDiffableDataSource<ViewControllerSection, String> {
        let dataSource = UITableViewDiffableDataSource<ViewControllerSection, String>(tableView: tableView) { tableView, indexPath, item in
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PokemonCell.identifier, for: indexPath) as? PokemonCell else { return UITableViewCell() }
            let pokemon = self.pokemons[indexPath.row]
            cell.nameLabel.text = pokemon
            return cell
        }
        return dataSource
    }
    
    func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<ViewControllerSection, String>()
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
        let name = pokemons[indexPath.row]
        presenter.cellClicked(name: name, num: indexPath.row+1)
    }
    
}

extension ViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        if (position > self.tableView.contentSize.height - scrollView.frame.size.height - 20) {
            self.tableView.tableFooterView = createLoadingSpinerFooter()
            DispatchQueue.main.async {
                self.tableView.tableFooterView = nil
            }
            presenter.didScrollView()
        }
    }
}


