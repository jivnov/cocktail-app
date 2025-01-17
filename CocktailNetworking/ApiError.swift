//
//  ApiError.swift
//  CocktailApp
//
//  Created by Andrei Zhyunou on 01/12/2024.
//

import Foundation

public enum ApiError: Error {
    case invalidUrl
    case unauthorized
    case decodingError
    case noResponse
    case unknown
        
    public var description: String {
        switch self {
        case .invalidUrl:
            return "Something wrong with the provided url"
        case .unauthorized:
            return "Provided credentials are wrong"
        case .decodingError:
            return "An error occure while decoding the request"
        case .noResponse:
            return "No response from server"
        default:
            return "Unknown error"
        }
    }
}
