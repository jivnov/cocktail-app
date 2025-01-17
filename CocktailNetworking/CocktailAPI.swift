//
//  CocktailAPI.swift
//  CocktailApp
//
//  Created by Andrei Zhyunou on 01/12/2024.
//

import Foundation

public protocol CocktailAPIProtocol {
    func fetchCocktails() async throws -> [any CocktailProtocol]
}

public struct CocktailAPI: CocktailAPIProtocol {
    private let baseURL: String
    private let credentials: String

    public init(baseURL: String, username: String, password: String) {
        self.baseURL = baseURL
        let credentialsString = "\(username):\(password)"
        self.credentials = Data(credentialsString.utf8).base64EncodedString()
    }

    public func fetchCocktails() async throws -> [any CocktailProtocol] {
        guard let url = URL(string: baseURL) else {
            throw ApiError.invalidUrl
        }
        
        let request = createAuthorizedRequest(url: url)

        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let response = response as? HTTPURLResponse else {
                throw ApiError.noResponse
            }
            
            switch response.statusCode {
            case 200...299:
                guard let decodedCocktails = try? JSONDecoder().decode([CocktailDTO].self, from: data) else {
                    throw ApiError.decodingError
                }
                return decodedCocktails
            case 401:
                throw ApiError.unauthorized
            default:
                throw ApiError.unknown
            }
        } 
    }
    
    private func createAuthorizedRequest(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.setValue("Basic \(credentials)", forHTTPHeaderField: "Authorization")
        return request
    }
}
