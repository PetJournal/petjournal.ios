//
//  LoginResponse.swift
//  petJournal
//
//  Created by Marcylene Barreto on 06/06/23.
//

import Foundation

struct LoginResponse: Codable {
    let accessToken: String?
}

struct LoginRequestBodyAuth: Codable {
    let email: String
    let password: String
}
