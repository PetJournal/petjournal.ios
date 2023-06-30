//
//  AccessAccountViewModel.swift
//  petJournal
//
//  Created by Marcylene Barreto on 24/03/23.
//

import SwiftUI

final class AccessAccountViewModel: ObservableObject {
    @Published var error: ErrorState = .none
    @Published var user: UserModel = UserModel.newUser
    @Published var cancel: Bool = false
    
    var service: AccessAccountServiceProtocol!
    init(service: AccessAccountServiceProtocol) {
        self.service = service
    }
    
    func loginUser() {
        if validFields(email: user.email, pass: user.password) {
            service.authenticationUser(userModel: user) { result in
                switch result {
                case .success:
                    let sessionModel = SessionModel(userName: self.user.email)
                    SessionManager.shared.updateValidation(with: sessionModel)
                case .failure:
                    self.error = .domainErr
                }
            }
        } else {
            error = .domainErr
            cancel.toggle()
        }
    }
}

extension AccessAccountViewModel {
    func validFields(email: String, pass: String) -> Bool {
        if Validations.shared.validFieldsLogin(email, password: pass) {
           return true
        }
        return false
    }
    
    var completeLogin: Bool {
        if !Validations.shared.validFieldsLogin(user.email, password: user.password) {
            return false
        }
        return true
    }
    
    var isInvalidEmail: String {
        if user.email.count > 4 {
            if !Validations.shared.validEmail(user.email) {
                return "Invalid Email adress"
            }
        }
        return ""
    }
    
    var isInvalidPassword: String {
        if user.password.count > 4 {
            if Validations.shared.isValidPassword(user.password) {
                return "Digite uma senha valida"
            }
        }
        return ""
    }
}
