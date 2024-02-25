//
//  ListInteractorTest.swift
//  PokeDoki
//
//  Created by Soto Nicole on 26.02.24.
//

import XCTest
@testable import PokeDoki


class ListInteractorTests: XCTestCase {
    
    var sut: ListInteractor!
    
    private var mockApi: MockAPICaller!
    private var mockPresenter: MockPresenter!
    
    override func setUp() {
        super.setUp()
        mockApi = MockAPICaller()
        mockPresenter = MockPresenter()
        sut = ListInteractor(presenter: mockPresenter, apiService: mockApi)
    }
    
    override func tearDown() {
        sut = nil
        mockApi = nil
        mockPresenter = nil
        super.tearDown()
    }
    
    func testOpenUrl_Success() {
        // given
        let expetedData = ["Bulbasaur", "Charmander", "Squirtle"]
        let testData = expetedData.map { PokemonSection(name: $0) }
        mockApi.stubbedFetchPokeDataCompletionResult = (.success(testData), ())
        
        // when
        var resultData: [String] = []
        sut.openUrl { names in
            resultData = names
        }
        
        // then
        XCTAssertEqual(mockApi.invokedFetchPokeDataCount, 1)
        XCTAssertEqual(expetedData, resultData)
    }
    
    class MockPresenter: ListPresenterProtocol {
        
        var router: ListRouterProtocol?
        
        var pokemonNames: [String] = []
        
        func cellClicked(name: String, num: Int) {
            
        }
        
        func configureView() {
            
        }
        
        func didScrollView() {
            
        }
        
    }
    
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
    
}
