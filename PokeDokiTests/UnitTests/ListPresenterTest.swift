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

