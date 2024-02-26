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
        
        let headerView = CustomTableHeaderView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 200))
        let headerImage = UIImage(named: "header_view")
        headerView.headerImageView.image = headerImage
        tableView.tableHeaderView = headerView
        view.addSubview(tableView)
        
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
    
    private func applySnapshot() {
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


class CustomTableHeaderView: UIView {
    let headerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(headerImageView)
        
        NSLayoutConstraint.activate([
            headerImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            headerImageView.topAnchor.constraint(equalTo: topAnchor),
            headerImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init's not implemented'")
    }
}
