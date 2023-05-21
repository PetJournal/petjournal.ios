//
//  LoginService.swift
//  petJournal
//
//  Created by Marcylene Barreto on 18/04/23.
//

import Foundation

protocol AccessAccountServiceProtocol {
    func authenticationUser(email: String, password: String, completion: @escaping (Result<SignState, ErrorApp>) -> Void)
}

final class AccessAccountService: AccessAccountServiceProtocol {
    
    func authenticationUser(email: String, password: String, completion: @escaping (Result<SignState, ErrorApp>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if !email.isEmpty && !password.isEmpty {
                completion(.success(.signedIn))
            } else {
                completion(.failure(.errorAuthentication))
            }
        }
    }
}
