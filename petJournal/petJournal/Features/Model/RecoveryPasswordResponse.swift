//
//  RecoveryPasswordResponse.swift
//  petJournal
//
//  Created by Ana Julia Brito de Souza on 11/10/23.
//

import Foundation

struct ForgetPasswordResponse: Codable {
    let message: String
}

struct RecoveryPasswordRequestBodyForgetPassword: Codable {
    let email: String
}

struct WaitingCodeResponse: Codable {
    let acessToken: String
}

struct RecoveryPasswordRequestBodyWaitingCode: Codable {
    let email: String
    let verificationToken: String
}

