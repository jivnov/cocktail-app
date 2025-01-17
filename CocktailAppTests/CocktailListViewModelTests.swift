//
//  CocktailAppTests.swift
//  CocktailAppTests
//
//  Created by Andrei Zhyunou on 01/12/2024.
//

import XCTest
@testable import CocktailApp
@testable import CocktailNetworking

final class CocktailListViewModelTests: XCTestCase {
    private var mockAPI: CocktailAPIMock!
    private var viewModel: CocktailListViewModel!
    
    override func setUp() {
        super.setUp()
        mockAPI = CocktailAPIMock()
        viewModel = CocktailListViewModel(api: mockAPI)
    }
    
    override func tearDown() {
        mockAPI = nil
        viewModel = nil
        super.tearDown()
    }
    
    func testFetchCocktails_Success() async {
        let expectedCocktails = [
            CocktailDTO(id: "1", name: "Mojito", imageUrl: "https://example.com/mojito.jpg"),
            CocktailDTO(id: "2", name: "Martini", imageUrl: "https://example.com/martini.jpg")
        ]
        mockAPI.setMockCoctails(expectedCocktails)
        await viewModel.fetchCocktails()
        
        XCTAssertEqual(viewModel.cocktails.count, expectedCocktails.count, "Cocktails number should match the mock data")
        XCTAssertNil(viewModel.error, "Error should be nil")
    }
    
    func testFetchCocktails_Failure() async {
        mockAPI.setMockError(ApiError.noResponse.self)
        await viewModel.fetchCocktails()
        XCTAssertTrue(viewModel.cocktails.isEmpty, "Cocktails should be empty on failure")
        XCTAssertNotNil(viewModel.error, "Error should not be nil")
    }
    
    func testFetchCocktails_EmptyResponse() async {
        mockAPI.setMockCoctails([])
        await viewModel.fetchCocktails()
        
        XCTAssertTrue(viewModel.cocktails.isEmpty, "Cocktails should be empty on EmptyResponse")
        XCTAssertNil(viewModel.error, "Error should be nil")
    }
}
