//
//  CocktailDTO.swift
//  CocktailApp
//
//  Created by Andrei Zhyunou on 01/12/2024.
//

import Foundation

public protocol CocktailProtocol: Identifiable {
    var id: String { get }
    var name: String { get }
    var imageUrl: String { get }
}

struct CocktailDTO: CocktailProtocol, Decodable {
    let id: String
    let name: String
    let imageUrl: String
}
