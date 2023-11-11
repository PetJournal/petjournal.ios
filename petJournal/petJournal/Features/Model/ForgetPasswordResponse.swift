//
//  ForgetPasswordResponse.swift
//  petJournal
//
//  Created by Ana Julia Brito de Souza on 30/10/23.
//

import Foundation

struct ForgetPasswordResponse: Decodable {
    let message: String
}

struct RecoveryPasswordRequestBodyForgetPassword: Codable {
    let email: String
}
