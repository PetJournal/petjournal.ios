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
        service.authenticationEmail(userModel: userSession) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.error = .none
                if self.userSession.email == self.user.email  {
                    let sessionModel = SessionModel(userName: self.user.email)
                    SessionManager.shared.updateValidation(with: sessionModel)
                }
            case .failure(let error):
                switch error {
                case .errorAuthentication:
                    self.error = .domainErr
                    self.cancel.toggle()
                case .errorSignIn:
                    self.error = .noRegister
                    self.cancel.toggle()
                }
            }
        }
    }
}

extension AccessAccountViewModel {
    func completeLogin() -> Bool {
        if (ValidationsModel.shared.validateInput(user.password, of: .password(.default)) == nil) &&
        (ValidationsModel.shared.validateInput(user.email, of: .email(.default)) == nil) {
            return false
        }
        return true
    }
    
    var isValidEmail: Bool {
        ValidationsModel.shared.validateInput(user.email, of: .email(.default)) == nil
    }
    
    var isValidPassword: Bool {
        ValidationsModel.shared.validateInput(user.password, of: .password(.default)) == nil
    }
    
    var emailErrorMessage: String {
        if user.email.count > 3 {
            if let errorValidation = ValidationsModel.shared.validateInput(user.email, of: .email(.default)) {
                let message = errorValidation.reason
                return message
            }
        }
        return String()
    }
    
    var passwordErrorMessage: String {
        if user.password.count > 3 {
            if let errorValidation = ValidationsModel.shared.validateInput(user.password, of: .password(.default)) {
                let message = errorValidation.reason
                return message
            }
        }
        return String()
    }
}

