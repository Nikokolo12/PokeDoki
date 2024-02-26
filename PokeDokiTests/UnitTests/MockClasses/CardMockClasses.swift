//
//  CardMockClasses.swift
//  PokeDokiTests
//
//  Created by Soto Nicole on 26.02.24.
//

import Foundation
import XCTest
@testable import PokeDoki

class MockCardInteractor: CardInteractorProtocol {
    
    var invokedModelPokemonItemSetter = false
    var invokedModelPokemonItemSetterCount = 0
    var invokedModelPokemonItem: [PokemonItem]?
    var invokedModelPokemonItemList = [[PokemonItem]]()
    var invokedModelPokemonItemGetter = false
    var invokedModelPokemonItemGetterCount = 0
    var stubbedModelPokemonItem: [PokemonItem]! = []
    
    var modelPokemonItem: [PokemonItem] {
        set {
            invokedModelPokemonItemSetter = true
            invokedModelPokemonItemSetterCount += 1
            invokedModelPokemonItem = newValue
            invokedModelPokemonItemList.append(newValue)
        }
        get {
            invokedModelPokemonItemGetter = true
            invokedModelPokemonItemGetterCount += 1
            return stubbedModelPokemonItem
        }
    }
    
    var invokedOpenUrl = false
    var invokedOpenUrlCount = 0
    var invokedOpenUrlParameters: (num: Int, Void)?
    var invokedOpenUrlParametersList = [(num: Int, Void)]()
    var stubbedOpenUrlCompletionResult: (pokeInfo, Void)?
    
    func openUrl(num: Int, completion: @escaping (pokeInfo) -> Void) {
        invokedOpenUrl = true
        invokedOpenUrlCount += 1
        invokedOpenUrlParameters = (num, ())
        invokedOpenUrlParametersList.append((num, ()))
        if let result = stubbedOpenUrlCompletionResult {
            completion(result.0)
        }
    }
    
    var invokedGetPokemonItem = false
    var invokedGetPokemonItemCount = 0
    var invokedGetPokemonItemParameters: (num: Int, Void)?
    var invokedGetPokemonItemParametersList = [(num: Int, Void)]()
    var stubbedGetPokemonItemCompletionResult: (pokeInfo, Void)?
    
    func getPokemonItem(num: Int, completion: @escaping (pokeInfo) -> Void) {
        invokedGetPokemonItem = true
        invokedGetPokemonItemCount += 1
        invokedGetPokemonItemParameters = (num, ())
        invokedGetPokemonItemParametersList.append((num, ()))
        if let result = stubbedGetPokemonItemCompletionResult {
            completion(result.0)
        }
    }
}

class MockCardPresenter: CardPresenterProtocol {
    
    var invokedRouterSetter = false
    var invokedRouterSetterCount = 0
    var invokedRouter: CardRouterProtocol?
    var invokedRouterList = [CardRouterProtocol?]()
    var invokedRouterGetter = false
    var invokedRouterGetterCount = 0
    var stubbedRouter: CardRouterProtocol!
    
    var router: CardRouterProtocol? {
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
    
    var invokedConfigureCardView = false
    var invokedConfigureCardViewCount = 0
    
    func configureCardView() {
        invokedConfigureCardView = true
        invokedConfigureCardViewCount += 1
    }
    
    var invokedCloseButtonClicked = false
    var invokedCloseButtonClickedCount = 0
    
    func closeButtonClicked() {
        invokedCloseButtonClicked = true
        invokedCloseButtonClickedCount += 1
    }
    
    var invokedSendData = false
    var invokedSendDataCount = 0
    var invokedSendDataParameters: (name: String, num: Int)?
    var invokedSendDataParametersList = [(name: String, num: Int)]()
    
    func sendData(name: String, num: Int) {
        invokedSendData = true
        invokedSendDataCount += 1
        invokedSendDataParameters = (name, num)
        invokedSendDataParametersList.append((name, num))
    }
}

class MockCardRouter: CardRouterProtocol{
    
    var invokedCloseCurrentViewController = false
    var invokedCloseCurrentViewControllerCount = 0
    
    func closeCurrentViewController() {
        invokedCloseCurrentViewController = true
        invokedCloseCurrentViewControllerCount += 1
    }
}

class MockCardView: CardViewProtocol{
    
    var invokedConfigureComponents = false
    var invokedConfigureComponentsCount = 0
    var invokedConfigureComponentsParameters: (tuple: pokeInfo, name: String)?
    var invokedConfigureComponentsParametersList = [(tuple: pokeInfo, name: String)]()
    
    func configureComponents(tuple: pokeInfo, name: String) {
        invokedConfigureComponents = true
        invokedConfigureComponentsCount += 1
        invokedConfigureComponentsParameters = (tuple, name)
        invokedConfigureComponentsParametersList.append((tuple, name))
    }
}

class MockAPIService: CardAPIService{
    
    var invokedUrlGetter = false
    var invokedUrlGetterCount = 0
    var stubbedUrl: String! = ""
    
    override var url: String {
        invokedUrlGetter = true
        invokedUrlGetterCount += 1
        return stubbedUrl
    }
    
    var invokedSendData = false
    var invokedSendDataCount = 0
    var invokedSendDataParameters: (num: Int, Void)?
    var invokedSendDataParametersList = [(num: Int, Void)]()
    var stubbedSendDataCompletionResult: (Result<pokeInfo, APIErrors>, Void)?
    
    override func sendData(num: Int, completion: @escaping (Result<pokeInfo, APIErrors>) -> Void) {
        invokedSendData = true
        invokedSendDataCount += 1
        invokedSendDataParameters = (num, ())
        invokedSendDataParametersList.append((num, ()))
        if let result = stubbedSendDataCompletionResult {
            completion(result.0)
        }
    }
    
    var invokedRequest = false
    var invokedRequestCount = 0
    var stubbedRequestCompletionHandlerResult: (Result<Void, APIErrors>, Void)?
    
    override func request(completionHandler: @escaping (Result<Void, APIErrors>) -> Void) {
        invokedRequest = true
        invokedRequestCount += 1
        if let result = stubbedRequestCompletionHandlerResult {
            completionHandler(result.0)
        }
    }
    
}
