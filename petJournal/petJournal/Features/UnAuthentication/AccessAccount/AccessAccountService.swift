//
//  LoginService.swift
//  petJournal
//
//  Created by Marcylene Barreto on 18/04/23.
//

import Foundation

protocol AccessAccountServiceProtocol {
    func authenticationUser(userModel: UserModel, completion: @escaping (Result<UserModel, ErrorApp>) -> Void)
}

final class AccessAccountService: AccessAccountServiceProtocol {
    func authenticationUser(userModel: UserModel, completion: @escaping (Result<UserModel, ErrorApp>) -> Void) {
        let valid = Validations()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if !userModel.email.isEmpty && !userModel.password.isEmpty {
                completion(.success(userModel))
            } else {
                completion(.failure(.errorAuthentication))
            }
        }
    }
}
