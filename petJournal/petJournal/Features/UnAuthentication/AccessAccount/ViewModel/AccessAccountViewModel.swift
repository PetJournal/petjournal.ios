//
//  AccessAccountViewModel.swift
//  petJournal
//
//  Created by Marcylene Barreto on 24/03/23.
//

import SwiftUI

class AccessAccountViewModel: ObservableObject {
    
    @Published var error: ErrorState = .none
    @Published var user: UserModel = UserModel.newUser
    @Published var cancel: Bool = false
    
    var service: AccessAccountServiceProtocol!
    init(service: AccessAccountServiceProtocol) {
        self.service = service
    }
    
    func loginUser(completion: @escaping (SignState) -> Void) {
        if validFields(email: user.email, pass: user.password) {
            service.authenticationUser(email: user.email, password: user.password) { result in
                switch result {
                case .success:
                    completion(.signedIn)
                case .failure:
                    completion(.signedOut)
                    self.error = .errorValues
                }
            }
        } else {
            error = .domainErr
            cancel.toggle()
        }
    }
}

// MARK: - Extension AccessAccountViewModel
extension AccessAccountViewModel {
    func validFields(email: String, pass: String) -> Bool {
        if Validations.shared.validFields(email, pass) {
           return true
        }
        return false
    }
    
    var completeLogin: Bool {
        let validations = Validations()
        if !validations.validFields(user.email, user.password) {
            return false
        }
        return true
    }
    
    var isInvalidEmail: String {
        if !user.email.isEmpty && Validations.shared.validEmail(user.email) {
            return ""
        }
        return "Invalid Email adress"
    }
    
    var isInvalidPassword: String {
        if Validations.shared.isValidPassword(user.password) {
            return ""
        }
        return "Digite uma senha valida"
    }
}
