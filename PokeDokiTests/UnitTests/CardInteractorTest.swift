//
//  CardInteractorTest.swift
//  PokeDokiTests
//
//  Created by Soto Nicole on 26.02.24.
//

import Foundation
import XCTest
@testable import PokeDoki

class CardInteractorTest: XCTestCase {
    
    var sut: CardInteractor!
    
    private var mockPresenter: MockCardPresenter!
    private var mockAPIService: MockAPIService!
    
    override func setUp() {
        super.setUp()
        mockPresenter = MockCardPresenter()
        mockAPIService = MockAPIService()
        sut = CardInteractor(presenter: mockPresenter)
        sut.apiService = mockAPIService
    }
    
    override func tearDown() {
        mockPresenter = nil
        sut = nil
        mockAPIService = nil
        super.tearDown()
    }
    
    func test_openURL(){
        // given
        let num = 0
        // when
        sut.openUrl(num: num) { pokeInfo in
        }
        // then
        XCTAssertEqual(mockAPIService.invokedSendDataCount, 1)
        XCTAssertEqual(mockAPIService.invokedSendDataParameters?.num, num)
        
    }
    
    func test_getPokemonItem(){
        // given
        let expectedData: pokeInfo = (weight: 69.0, height: 7.0, types: ["grass", "poison"], image: UIImage())
        let num = 1
        mockAPIService.stubbedSendDataCompletionResult = (.success(expectedData), ())
        // when
        var result: pokeInfo = (0.0, 0.0, [], UIImage())
        sut.getPokemonItem(num: num) { pokeInfo in
            result = pokeInfo
        }
        // then
        XCTAssertEqual(expectedData.types, result.types)
        XCTAssertEqual(expectedData.height, result.height)
        XCTAssertEqual(expectedData.weight, result.weight)
        XCTAssertEqual(expectedData.types, result.types)
    }
}
