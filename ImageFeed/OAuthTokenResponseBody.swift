//
//  OAuthTokenResponseBody.swift
//  ImageFeed
//
//  Created by Тадевос Курдоглян on 27.12.2022.
//

import Foundation

struct OAuthTokenResponseBody: Codable {
    let accessToken: String
    let tokenType: String
    let scope: String
    let createdAt: Int
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case scope
        case createdAt = "created_a"
    }
}
