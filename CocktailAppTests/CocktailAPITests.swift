//
//  CocktailAPITests.swift
//  Cocktail
//
//  Created by Andrei Zhyunou on 01/12/2024.
//

import XCTest
@testable import CocktailNetworking

final class CocktailAPITests: XCTestCase {
    private var api: CocktailAPI!

    override func setUp() {
        super.setUp()
        URLProtocol.registerClass(URLSessionMock.self)
        api = CocktailAPI(baseURL: "https://example.com/cocktails", username: "user", password: "pass")
    }

    override func tearDown() {
        URLProtocol.unregisterClass(URLSessionMock.self)
        api = nil
        super.tearDown()
    }

    func testFetchCocktails_Success() async throws {
        let jsonData = """
        [
            { "id": "1", "name": "Mojito", "imageUrl": "" },
            { "id": "2", "name": "Martini", "imageUrl": "" }
        ]
        """.data(using: .utf8)!

        URLSessionMock.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, jsonData)
        }

        let cocktails = try await api.fetchCocktails()

        XCTAssertEqual(cocktails.count, 2)
        XCTAssertEqual(cocktails[0].name, "Mojito")
        XCTAssertEqual(cocktails[1].name, "Martini")
    }

    func testFetchCocktails_Unauthorized() async {
        URLSessionMock.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 401, httpVersion: nil, headerFields: nil)!
            return (response, Data())
        }

        do {
            _ = try await api.fetchCocktails()
            XCTFail("Expected an unauthorized error but got success")
        } catch {
            XCTAssertEqual(error as? ApiError, ApiError.unauthorized)
        }
    }

    func testFetchCocktails_DecodingError() async {
        let invalidJSON = "{ invalid data }".data(using: .utf8)!

        URLSessionMock.requestHandler = { request in
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, invalidJSON)
        }
        
        do {
            _ = try await api.fetchCocktails()
            XCTFail("Expected a decoding error but got success")
        } catch {
            XCTAssertEqual(error as? ApiError, ApiError.decodingError)
        }
    }
}
