//
//  ListMockClasses.swift
//  PokeDokiTests
//
//  Created by Soto Nicole on 26.02.24.
//

import Foundation
import XCTest
@testable import PokeDoki

class MockAPICaller: APICallerProtocol {
    var invokedBaseURLGetter = false
    var invokedBaseURLGetterCount = 0
    var stubbedBaseURL: String! = ""
    
    var baseURL: String {
        invokedBaseURLGetter = true
        invokedBaseURLGetterCount += 1
        return stubbedBaseURL
    }
    
    var invokedFetchPokeData = false
    var invokedFetchPokeDataCount = 0
    var invokedFetchPokeDataParameters: (pagination: Bool, Void)?
    var invokedFetchPokeDataParametersList = [(pagination: Bool, Void)]()
    var stubbedFetchPokeDataCompletionResult: (Result<[PokemonSection], APIErrors>, Void)?
    
    func fetchPokeData(pagination: Bool, completion: @escaping (Result<[PokemonSection], APIErrors>) -> Void) {
        invokedFetchPokeData = true
        invokedFetchPokeDataCount += 1
        invokedFetchPokeDataParameters = (pagination, ())
        invokedFetchPokeDataParametersList.append((pagination, ()))
        if let result = stubbedFetchPokeDataCompletionResult {
            completion(result.0)
        }
    }
}

class MockPresenter: ListPresenterProtocol{

    var invokedRouterSetter = false
    var invokedRouterSetterCount = 0
    var invokedRouter: ListRouterProtocol?
    var invokedRouterList = [ListRouterProtocol?]()
    var invokedRouterGetter = false
    var invokedRouterGetterCount = 0
    var stubbedRouter: ListRouterProtocol!

    var router: ListRouterProtocol? {
        set {
            invokedRouterSetter = true
            invokedRouterSetterCount += 1
            invokedRouter = newValue
            invokedRouterList.append(newValue)
        }
        get {
            invokedRouterGetter = true
            invokedRouterGetterCount += 1
            return stubbedRouter
        }
    }

    var invokedPokemonNamesSetter = false
    var invokedPokemonNamesSetterCount = 0
    var invokedPokemonNames: [String]?
    var invokedPokemonNamesList = [[String]]()
    var invokedPokemonNamesGetter = false
    var invokedPokemonNamesGetterCount = 0
    var stubbedPokemonNames: [String]! = []

    var pokemonNames: [String] {
        set {
            invokedPokemonNamesSetter = true
            invokedPokemonNamesSetterCount += 1
            invokedPokemonNames = newValue
            invokedPokemonNamesList.append(newValue)
        }
        get {
            invokedPokemonNamesGetter = true
            invokedPokemonNamesGetterCount += 1
            return stubbedPokemonNames
        }
    }

    var invokedCellClicked = false
    var invokedCellClickedCount = 0
    var invokedCellClickedParameters: (name: String, num: Int)?
    var invokedCellClickedParametersList = [(name: String, num: Int)]()

    func cellClicked(name: String, num: Int) {
        invokedCellClicked = true
        invokedCellClickedCount += 1
        invokedCellClickedParameters = (name, num)
        invokedCellClickedParametersList.append((name, num))
    }

    var invokedConfigureView = false
    var invokedConfigureViewCount = 0

    func configureView() {
        invokedConfigureView = true
        invokedConfigureViewCount += 1
    }

    var invokedDidScrollView = false
    var invokedDidScrollViewCount = 0

    func didScrollView() {
        invokedDidScrollView = true
        invokedDidScrollViewCount += 1
    }
}

class MockListView: ListViewProtocol {

    var invokedSetURLCellTitle = false
    var invokedSetURLCellTitleCount = 0
    var invokedSetURLCellTitleParameters: (names: [String], Void)?
    var invokedSetURLCellTitleParametersList = [(names: [String], Void)]()

    func setURLCellTitle(names: [String]) {
        invokedSetURLCellTitle = true
        invokedSetURLCellTitleCount += 1
        invokedSetURLCellTitleParameters = (names, ())
        invokedSetURLCellTitleParametersList.append((names, ()))
    }
}

class MockListRouter: ListRouterProtocol {

    var invokedCloseCurrentViewController = false
    var invokedCloseCurrentViewControllerCount = 0
    var invokedCloseCurrentViewControllerParameters: (name: String, num: Int)?
    var invokedCloseCurrentViewControllerParametersList = [(name: String, num: Int)]()

    func closeCurrentViewController(name: String, num: Int) {
        invokedCloseCurrentViewController = true
        invokedCloseCurrentViewControllerCount += 1
        invokedCloseCurrentViewControllerParameters = (name, num)
        invokedCloseCurrentViewControllerParametersList.append((name, num))
    }
}

class MockListInteractor: ListInteractorProtocol {

    var invokedUrlSourceGetter = false
    var invokedUrlSourceGetterCount = 0
    var stubbedUrlSource: String! = ""

    var urlSource: String {
        invokedUrlSourceGetter = true
        invokedUrlSourceGetterCount += 1
        return stubbedUrlSource
    }

    var invokedApiServiceSetter = false
    var invokedApiServiceSetterCount = 0
    var invokedApiService: APICallerProtocol?
    var invokedApiServiceList = [APICallerProtocol]()
    var invokedApiServiceGetter = false
    var invokedApiServiceGetterCount = 0
    var stubbedApiService: APICallerProtocol!

    var apiService: APICallerProtocol {
        set {
            invokedApiServiceSetter = true
            invokedApiServiceSetterCount += 1
            invokedApiService = newValue
            invokedApiServiceList.append(newValue)
        }
        get {
            invokedApiServiceGetter = true
            invokedApiServiceGetterCount += 1
            return stubbedApiService
        }
    }

    var invokedOpenUrl = false
    var invokedOpenUrlCount = 0
    var stubbedOpenUrlCompletionResult: ([String], Void)?

    func openUrl(completion: @escaping ([String]) -> Void) {
        invokedOpenUrl = true
        invokedOpenUrlCount += 1
        if let result = stubbedOpenUrlCompletionResult {
            completion(result.0)
        }
    }
}

class MockConfigurator: ListConfigurator{

    var invokedConfigure = false
    var invokedConfigureCount = 0
    var invokedConfigureParameters: (viewController: ViewController, Void)?
    var invokedConfigureParametersList = [(viewController: ViewController, Void)]()

    override func configure(viewController: ViewController) {
        invokedConfigure = true
        invokedConfigureCount += 1
        invokedConfigureParameters = (viewController, ())
        invokedConfigureParametersList.append((viewController, ()))
    }
}

