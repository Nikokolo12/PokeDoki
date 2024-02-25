//
//  ListInteractorTests.swift
//  PokeDokiTests
//
//  Created by Soto Nicole on 25.02.24.
//

import XCTest

@testable import PokeDoki

//class ListInteractorTests: XCTestCase {
//
//    var sut: ListInteractor!
//
//    override func setUp() {
//        super.setUp()
//        let mockAPI = MockAPICaller()
//        sut = ListInteractor(presenter: MockPresenter(), apiService: MockAPICaller)
//    }
//
//    override func tearDown() {
//        sut = nil
//        super.tearDown()
//    }
//
//    func testOpenUrl_Success() {
//        let mockAPI = MockAPICaller(result: .success(["Bulbasaur", "Charmander", "Squirtle"]))
//        sut.apiService = mockAPI
//        let expectation = XCTestExpectation(description: "Fetch Pokemon names successfully")
//
//        sut.openUrl { names in
//            XCTAssertEqual(names.count, 3, "Expected 3 names")
//            XCTAssertEqual(names, ["Bulbasaur", "Charmander", "Squirtle"], "Names should match expected values")
//            expectation.fulfill()
//        }
//
//        wait(for: [expectation], timeout: 5.0)
//    }
//
//    func testOpenUrl_Failure() {
//        let mockAPI = MockAPICaller(result: .success(["Bulbasaur", "Charmander", "Squirtle"]))
//        sut.apiService = mockAPI
//        let expectation = XCTestExpectation(description: "Fetch Pokemon names successfully")
//
//        sut.openUrl { names in
//            XCTAssertEqual(names.count, 0, "No names should be returned")
//            expectation.fulfill()
//        }
//
//        wait(for: [expectation], timeout: 5.0)
//    }
//}
//
//class MockPresenter: ListPresenterProtocol {
//
//    var router: ListRouterProtocol?
//
//    var pokemonNames: [String] = []
//
//    func cellClicked(name: String, num: Int) {
//
//    }
//
//    func configureView() {
//
//    }
//
//    func didScrollView() {
//
//    }
//
//}
//
//class MockAPICaller: APICallerProtocol {
//    var baseURL: String = ""
//
//    func fetchPokeData(pagination: Bool, completion: @escaping (Result<[PokemonSection], APIErrors>) -> Void) {
//
//    }
//}
