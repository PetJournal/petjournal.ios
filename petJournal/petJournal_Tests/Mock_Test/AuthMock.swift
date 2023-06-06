//
//  AuthMock.swift
//  petJournal_Tests
//
//  Created by Marcylene Barreto on 26/04/23.
//

@testable import petJournal

final class AuthMock: AccessAccountServiceProtocol {
    
    var signInSuccess: Bool?
    var error: Error?
    var isLogged: Bool = false
    
    init(signInSuccess: Bool = false, error: Error? = nil) {
        self.signInSuccess = signInSuccess
        self.error = error
    }
    
    func loginUser(email: String, password: String, completion: @escaping (Result<Bool, ErrorRegisterApp>) -> Void) {
        if signInSuccess! {
            isLogged = true
            completion(.success(true))
        } else {
            completion(.failure(.errorAuthentication))
        }
    }
}
