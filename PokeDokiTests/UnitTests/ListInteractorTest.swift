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
    
    func test_openURL() {
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
}

