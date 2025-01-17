//
//  Cocktail.swift
//  CocktailApp
//
//  Created by Andrei Zhyunou on 01/12/2024.
//

import Foundation
import CocktailNetworking

struct Cocktail: CocktailProtocol {
    let id: String
    let name: String
    let imageUrl: String
    
    init(id: String, name: String, imageUrl: String) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
    }
    
    init(from cp: any CocktailProtocol) {
        self.id = cp.id
        self.name = cp.name
        self.imageUrl = cp.imageUrl
    }
}

extension Cocktail {
    static let MOCK_COCKTAIL = Cocktail(id: "1", name: "Mock Cocktail", imageUrl: "")
}
