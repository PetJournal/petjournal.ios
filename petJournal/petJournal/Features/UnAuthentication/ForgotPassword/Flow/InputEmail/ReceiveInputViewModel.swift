//
//  ReceiveInputViewModel.swift
//  petJournal
//
//  Created by Marcylene Barreto on 14/06/23.
//

import Foundation

class ForgotPasswordViewModel: ObservableObject {
    @Published var error: ForgotError = .none
    @Published var forgotState: ForgotState = .unknown
    @Published var user: UserModel = UserModel.newUser
    @Published var cancel: Bool = false
    
    var service: ForgotPasswordServiceProtocol!
    init(service: ForgotPasswordServiceProtocol) {
        self.service = service
    }
    
    func reAuthentication() {
        if isCorrectEmail {
            service.forgotPassword(credential: user.email) { result in
                switch result {
                case .success:
                    self.forgotState = .forgotCheck
                    self.error = .none
                    UserDefaultsUtils.deleteData(key: KeysUser.email.rawValue)
                case .failure(_):
                    self.error = .invalidMail
                }
            }
        }
    }
}

// MARK: - Extension
extension ForgotPasswordViewModel {
    var isCorrectEmail: Bool {
        if !Validations.shared.validEmail(user.email) {
            return false
        }
        return true
    }
}
