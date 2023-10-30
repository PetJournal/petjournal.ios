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
    @Published var email = ""
    @Published var userSession: UserSession = .init()
    @Published var cancel: Bool = false
    @Published var isWaitingCode: Bool = false
    
    var service: ForgotPasswordServiceProtocol!
    init(service: ForgotPasswordServiceProtocol) {
        self.service = service
    }
    
    func forgetPassword() {
        if isCorrectCredentials {
            service.forgotPassword(email: email) { result in
                switch result {
                case .success:
                    DispatchQueue.main.sync {
                        self.forgotState = .forgotCheck
                        self.error = .none
                        UserDefaultsUtils.deleteData(key: KeysUser.email.rawValue)
                        self.isWaitingCode = true
                    }
                case .failure(_):
                    DispatchQueue.main.sync {
                        self.error = .invalidMail
                        self.cancel = true
                    }
                }
            }
        }
    }
}

// MARK: - Extension
extension ForgotPasswordViewModel {
    var isCorrectCredentials: Bool {
        if isValidEmail {
            return true
        }
        return false
    }
    
    var isValidEmail: Bool {
        ValidationsModel.shared.validateInput(email, of: .email(.default)) == nil
    }
    
    var emailErrorMessage: String {
        if email.count > 3 {
            if !isCorrectCredentials{
                return "Insira os dados corretamente"
            }
        }
        return ""
    }
    
    var emailError: String {
        if let errorValidation = ValidationsModel.shared.validateInput(email, of: .email(.default)) {
            let messageEmail = errorValidation.reason
            return messageEmail
        }
        return ""
    }
    
    var phoneError: String {
        if let errorValidationPhone = ValidationsModel.shared.validateInput(email, of: .phone(.default)) {
            let messagePhone = errorValidationPhone.reason
            return messagePhone
        }
        return ""
    }
}
