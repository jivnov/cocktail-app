//
//  CocktailAPIMock.swift
//  Cocktail
//
//  Created by Andrei Zhyunou on 01/12/2024.
//

import CocktailNetworking

final class CocktailAPIMock: CocktailAPIProtocol {
    
    private var mockCoctails: [any CocktailProtocol] = []
    private var mockError: ApiError? = nil
    
    func fetchCocktails() async throws -> [any CocktailProtocol] {
        if let error = mockError {
            throw error
        }
        
        return self.mockCoctails
    }
    
    func setMockCoctails(_ mockCoctails: [any CocktailProtocol]) {
       self.mockCoctails = mockCoctails
   }
   
    func setMockError(_ mockError: ApiError) {
       self.mockError = mockError
   }
}
