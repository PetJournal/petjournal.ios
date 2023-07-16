//
//  LoginService.swift
//  petJournal
//
//  Created by Marcylene Barreto on 18/04/23.
//

import Foundation

protocol AccessAccountServiceProtocol {
    func authenticationEmail(userModel: UserSession, completion: @escaping (Result<UserSession, ErrorApp>) -> Void)
}

final class AccessAccountService: AccessAccountServiceProtocol {
    func authenticationEmail(userModel: UserSession, completion: @escaping (Result<UserSession, ErrorApp>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            guard let email = userModel.email else { return }
            guard let password = userModel.password else { return }
            if !email.isEmpty && !password.isEmpty {
                completion(.success(userModel))
            } else {
                completion(.failure(.errorAuthentication))
            }
        }
    }
}
