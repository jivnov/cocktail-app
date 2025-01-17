//
//  CocktailDataModelsTest.swift
//  Cocktail
//
//  Created by Andrei Zhyunou on 01/12/2024.
//

import XCTest
@testable import CocktailApp
@testable import CocktailNetworking

final class CocktailDataModelsTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testCocktailDTOParsing() throws {
        let json = """
        {
            "id": "1",
            "name": "Mojito",
            "imageUrl": "https://example.com/mojito.jpg"
        }
        """.data(using: .utf8)!

        let decoder = JSONDecoder()
        let dto = try decoder.decode(CocktailDTO.self, from: json)

        XCTAssertEqual(dto.id, "1", "DTO parsing id should be correct")
        XCTAssertEqual(dto.name, "Mojito", "DTO parsing name should be correct")
        XCTAssertEqual(dto.imageUrl, "https://example.com/mojito.jpg", "DTO parsing image url should be correct")
    }
    
    func testCocktailDTOToModelMapping() {
        let cocktailId = "1"
        let cocktailName = "Mojito"
        let cocktailImageUrl = "https://example.com/mojito.jpg"
        let cocktailDTO = CocktailDTO(id: cocktailId, name: cocktailName, imageUrl: cocktailImageUrl)
        let coctailModel: Cocktail =  Cocktail(from: cocktailDTO)
        
        XCTAssertEqual(coctailModel.id, cocktailId, "DTO to model mapping id should be correct")
        XCTAssertEqual(coctailModel.name, cocktailName, "DTO to model mapping name should be correct")
        XCTAssertEqual(coctailModel.imageUrl, cocktailImageUrl, "DTO to model mapping image url should be correct")
    }
}
