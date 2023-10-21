//
//  AccessAccountViewModel.swift
//  petJournal
//
//  Created by Marcylene Barreto on 24/03/23.
//

import SwiftUI

final class AccessAccountViewModel: ObservableObject {
    @Published var user: UserModel = UserModel.newUser
    @Published var userSession: UserSession = .init()
    @Published var cancel: Bool = false
    
    var service: AccessAccountServiceProtocol!
    init(service: AccessAccountServiceProtocol) {
        self.service = service
    }
    
    func authUser() {
        SessionManager.shared.statusLogin = .unknown
        service.authenticationEmail(email: user.email, password: user.password) { result in
            switch result {
            case .success(let token):
                SessionManager.shared.login(withToken: token)
                DispatchQueue.main.async {
                    SessionManager.shared.statusLogin = .signIn
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    SessionManager.shared.statusLogin = .signOut
                }
                print("\(error.localizedDescription)")
            }
        }
    }
    
    func logout() {
        if SessionManager.shared.isAuthenticated {
            DispatchQueue.main.async {
                SessionManager.shared.logout()
                SessionManager.shared.statusLogin = .signOut
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
