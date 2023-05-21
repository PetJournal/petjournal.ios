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
    
    func authenticationUser(email: String, password: String, completion: @escaping (Result<petJournal.SignState, petJournal.ErrorApp>) -> Void) {
        if signInSuccess! {
            isLogged = true
            completion(.success(.signedIn))
        } else {
            completion(.failure(.errorAuthentication))
        }
    }
}
