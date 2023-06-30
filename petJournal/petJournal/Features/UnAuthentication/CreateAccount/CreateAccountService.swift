//
//  CreateAccountService.swift
//  petJournal
//
//  Created by Daiane Goncalves on 19/05/23.
//

import Foundation

protocol CreateAccountServiceProtocol {
    func registerUser(userModel: UserModel, completion: @escaping (Result<UserModel, ErrorRegisterApp>) -> Void)
}

class CreateAccountService: CreateAccountServiceProtocol {
    func registerUser(userModel: UserModel, completion: @escaping (Result<UserModel, ErrorRegisterApp>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if userModel.email == "user@petjournal.com" && userModel.password == "password@123" {
                completion(.success(userModel))
            } else {
                completion(.failure(.errorRegister))
            }
        }
    }
}
