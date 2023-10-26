//
//  RegisterResponse.swift
//  petJournal
//
//  Created by Marcylene Barreto on 25/10/23.
//

import Foundation

struct RegisterRequestBody: Codable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
    let passwordConfirmation: String
    let phone: String
    let isPrivacyPolicyAccepted: Bool
}

struct RegisterResponse: Codable {
    let user: UserModel?
}
