//
//  LoginService.swift
//  petJournal
//
//  Created by Marcylene Barreto on 18/04/23.
//

import Foundation

protocol AccessAccountServiceProtocol {
    func loginUser(email: String, password: String, completion: @escaping(Result<Bool,ErrorApp>) -> Void)
}

final class AccessAccountService: AccessAccountServiceProtocol {
    
    func loginUser(email: String, password: String, completion: @escaping (Result<Bool, ErrorApp>) -> Void) {
        let valid = Validations()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if valid.validFields(email, password: password) {
                completion(.success(true))
            } else {
                completion(.failure(ErrorApp.errorAuthentication))
            }
        }
    }
}
