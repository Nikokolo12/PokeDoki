//
//  ListPresenterTest.swift
//  PokeDoki
//
//  Created by Soto Nicole on 26.02.24.
//

import XCTest
@testable import PokeDoki

class ListPresenterTests: XCTestCase {
    
    private var sut: ListPresenter!

    private var mockView: MockListView!
    private var mockRouter: MockListRouter!
    private var mockInteractor: MockListInteractor!
    
    override func setUp() {
        super.setUp()
        mockView = MockListView()
        mockInteractor = MockListInteractor()
        mockRouter = MockListRouter()
        sut = ListPresenter(view: mockView)
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
    
    func test_cellClicked() {
        // given
        let name = "test"
        let num = 1
        
        // when
        sut.cellClicked(name: name, num: num)
        
        // then
        XCTAssertEqual(mockRouter.invokedCloseCurrentViewControllerCount, 1)
        XCTAssertEqual(mockRouter.invokedCloseCurrentViewControllerParameters?.name, name)
        XCTAssertEqual(mockRouter.invokedCloseCurrentViewControllerParameters?.num, num)
    }
    
}
