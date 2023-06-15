//
//  ForgotPasswordService.swift
//  petJournal
//
//  Created by Marcylene Barreto on 14/06/23.
//

import Foundation

protocol ForgotPasswordServiceProtocol {
    func forgotPassword(credential: String, completion: @escaping (Result<Bool, ForgotError>) -> Void)
}

class ForgotPasswordService: ForgotPasswordServiceProtocol {
    func forgotPassword(credential: String, completion: @escaping (Result<Bool, ForgotError>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if !credential.isEmpty {
                completion(.success(true))
            } else {
//                completion(.failure(ErrorForgot.mailInvalid))
            }
        }
    }
}
