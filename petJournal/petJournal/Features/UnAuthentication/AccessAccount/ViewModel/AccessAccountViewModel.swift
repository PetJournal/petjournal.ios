//
//  AccessAccountViewModel.swift
//  petJournal
//
//  Created by Marcylene Barreto on 24/03/23.
//

import Foundation

final class AccessAccountViewModel {
    
    var error: ObservableObject<ErrorState> = .init(.none)
    var singState: ObservableObject<SignState> = .init(.signedOut)
    
    var service: AccessAccountServiceProtocol!
    init(service: AccessAccountServiceProtocol) {
        self.service = service
    }
    
    func authUser(_ email: String, pass: String) {
        service.loginUser(email: email, password: pass) { result in
            switch result {
            case .success:
                self.singState = .init(.signedIn)
            case .failure(let error):
                switch error {
                case .errorAuthentication:
                    self.singState = .init(.signedOut)
                case .errorSignIn:
                    self.singState = .init(.signedOut)
                }
            }
        }
    }
}
