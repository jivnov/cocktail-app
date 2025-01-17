//
//  AppSecrets.swift
//  CocktailApp
//
//  Created by Andrei Zhyunou on 01/12/2024.
//

import Foundation

struct ApiCredentials {
    static let serverURL: String = {
        "http://cocktails-data.eu-central-1.elasticbeanstalk.com/cocktails"
    }()

    static let userName: String = {
        getBundleObject(for: "USER_NAME")
    }()

    static let password: String = {
        getBundleObject(for: "PASSWORD")
    }()
    
    private static func getBundleObject(for key: String) -> String {
        guard let object = Bundle.main.object(forInfoDictionaryKey: key) as? String else {
            print("\(key) not found in Info.plist")
            return ""
        }
        
        return object
    }
}
