//
//  LoginService.swift
//  petJournal
//
//  Created by Marcylene Barreto on 18/04/23.
//

import Foundation

protocol AccessAccountServiceProtocol {
    func loginUser(email: String, password: String, completion: @escaping(Result<Bool,ErrorRegisterApp>) -> Void)
}

final class AccessAccountService: AccessAccountServiceProtocol {
    func loginUser(email: String, password: String, completion: @escaping (Result<Bool, ErrorRegisterApp>) -> Void) {
        let valid = Validations()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if valid.validFieldsLogin(email, password: password) {
                completion(.success(true))
            } else {
                completion(.failure(ErrorRegisterApp.errorRegister))
            }
        }
    }
}
