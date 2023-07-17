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
    @Published var userSession: UserSession = .init()
    @Published var cancel: Bool = false
    
    var service: AccessAccountServiceProtocol!
    init(service: AccessAccountServiceProtocol) {
        self.service = service
    }
    
    func authUser() {
        service.authenticationEmail(userModel: userSession) { result in
            switch result {
            case .success:
                if self.userSession.email == self.user.email  {
                    let sessionModel = SessionModel(userName: self.user.email)
                    SessionManager.shared.updateValidation(with: sessionModel)
                }
            case .failure:
                self.error = .domainErr
                self.cancel.toggle()
            }
        }
        self.error = .noRegister
        self.cancel.toggle()
    }
}

extension AccessAccountViewModel {
    
    var completeLogin: Bool {
        if !Validations.shared.validFieldsLogin(user.email, password: user.password)   {
            if userSession.email != user.email {
                return false
            }
        }
        return true
    }
    
    var emailErrorMessage: String {
        if user.email.count > 4 && (userSession.email != user.email) {
            if !Validations.shared.validEmail(user.email) {
                return "*Invalid email adress"
            }
        }
        return ""
    }
    
    var passwordErrorMessage: String {
        if user.password.count > 4 {
            if !Validations.shared.isValidPassword(user.password) {
                return "*Digite uma senha valida"
            }
        }
        return ""
    }
}
