//
//  CardPresenterTest.swift
//  PokeDokiTests
//
//  Created by Soto Nicole on 26.02.24.
//

import Foundation

import XCTest
@testable import PokeDoki


class CardPresenterTest: XCTestCase {
    
    var sut: CardPresenter!
    
    private var mockInteractor: MockCardInteractor!
    private var mockRouter: MockCardRouter!
    private var mockView: MockCardView!
    
    override func setUp() {
        super.setUp()
        mockView = MockCardView()
        mockInteractor = MockCardInteractor()
        mockRouter = MockCardRouter()
        sut = CardPresenter(view: mockView)
        sut.router = mockRouter
        sut.interactor = mockInteractor
    }
    
    override func tearDown() {
        mockView = nil
        sut = nil
        mockInteractor = nil
        mockRouter = nil
        super.tearDown()
    }
    
    func test_closeButtonClicked(){
        // given
        
        // when
        sut.closeButtonClicked()
        // then
        XCTAssertEqual(mockRouter.invokedCloseCurrentViewControllerCount, 1)
    }
    
    func test_configureCardView(){
        // given
        
        // when
        sut.configureCardView()
        //then
        XCTAssertEqual(mockView.invokedConfigureComponentsCount, 1)
    }
    
    func test_sendData(){
        // given
        let name = ""
        let num = 0
        // when
        sut.sendData(name: name, num: num)
        // then
        XCTAssertEqual(mockInteractor.invokedGetPokemonItemCount, 1)
        XCTAssertEqual(mockInteractor.invokedGetPokemonItemParameters?.num, num)
    }
}
