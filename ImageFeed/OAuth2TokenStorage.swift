//
//  OAuth2TokenStorage.swift
//  ImageFeed
//
//  Created by Тадевос Курдоглян on 29.12.2022.
//

import Foundation

final class OAuth2TokenStorage {
    
    private let userDefaults = UserDefaults.standard
    
    var token: String? {
        get {
            userDefaults.string(forKey: "bearerToken")
        }

        set {
            userDefaults.set(newValue, forKey: "bearerToken")
        }
    }
}
