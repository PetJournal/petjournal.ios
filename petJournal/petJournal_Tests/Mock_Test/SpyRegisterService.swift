//
//  RegisterService.swift
//  petJournal_Tests
//
//  Created by Marcylene Barreto on 06/06/23.
//

@testable import petJournal

final class SpyRegisterService: CreateAccountServiceProtocol {

    var signUpSuccess: Bool?
    var error: Error?
    var isRegister: Bool = false
    
    init(signUpSuccess: Bool = false, error: Error? = nil) {
        self.signUpSuccess = signUpSuccess
        self.error = error
    }
    
    func registerUser(userModel: petJournal.UserModel, completion: @escaping (Result<petJournal.UserModel, petJournal.ErrorRegisterApp>) -> Void) {
        if signUpSuccess! {
            isRegister = true
            completion(.success(userModel))
        } else {
            completion(.failure(.errorRegister))
        }
    }
}
