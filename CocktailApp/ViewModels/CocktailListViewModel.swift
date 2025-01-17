//
//  CocktailListViewModel.swift
//  CocktailApp
//
//  Created by Andrei Zhyunou on 01/12/2024.
//

import Foundation
import CocktailNetworking

class CocktailListViewModel: ObservableObject {
    @Published var cocktails: [Cocktail] = []
    @Published var error: String?

    private let api: CocktailAPIProtocol

    init(api: CocktailAPIProtocol) {
        self.api = api
        
        Task { await fetchCocktails() }
    }
    
    convenience init() {
        let api = CocktailAPI(
            baseURL: ApiCredentials.serverURL,
            username: ApiCredentials.userName,
            password: ApiCredentials.password
        )
        
        self.init(api: api)
    }
    
    @MainActor
    func fetchCocktails() async {
        do {
            let fetchedCocktails = try await api.fetchCocktails()
            let coctails: [Cocktail] = fetchedCocktails.map { Cocktail(from: $0) }
            self.cocktails = coctails
        } catch {
            self.error = errorDescription(for: error)
        }
    }
    
    func resetError() {
        error = nil
    }
    
    private func errorDescription(for error: Error) -> String {
        if let apiError = error as? ApiError {
            return apiError.description
        } else {
            return error.localizedDescription
        }
    }
}
