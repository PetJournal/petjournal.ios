//
//  ForgotPasswordService.swift
//  petJournal
//
//  Created by Marcylene Barreto on 15/05/23.
//

import Foundation

protocol ForgotPasswordServiceProtocol {
    func forgotPassword(credential: String, completion: @escaping (Result<Bool, ErrorForgot>) -> Void)
}

class ForgotPasswordService: ForgotPasswordServiceProtocol {
    func forgotPassword(credential: String, completion: @escaping (Result<Bool, ErrorForgot>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if !credential.isEmpty {
                completion(.success(true))
            } else {
                completion(.failure(ErrorForgot.mailInvalid))
            }
        }
    }
}
