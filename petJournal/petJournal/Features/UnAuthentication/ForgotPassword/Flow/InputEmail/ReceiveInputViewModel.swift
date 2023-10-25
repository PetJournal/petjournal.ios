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
    @Published var emailOrPhone = ""
    @Published var userSession: UserSession = .init()
    @Published var cancel: Bool = false
    
    var service: ForgotPasswordServiceProtocol!
    init(service: ForgotPasswordServiceProtocol) {
        self.service = service
    }
    
    func reAuthentication() {
        if isCorrectCredentials {
            service.forgotPassword(credential: emailOrPhone) { result in
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
    var isCorrectCredentials: Bool {
        if isValidEmail || isValidPhone {
            return true
        }
        return false
    }
    
    var isValidEmail: Bool {
        ValidationsModel.shared.validateInput(emailOrPhone, of: .email(.default)) == nil
    }
    
    var isValidPhone: Bool {
        ValidationsModel.shared.validateInput(emailOrPhone, of: .phone(.default)) == nil
    }
    
    var emailErrorMessage: String {
        if emailOrPhone.count > 3 {
            if !isCorrectCredentials{
                return "forgotpassword-invalid-email".localized
            }
        }
        return ""
    }
    
    var emailError: String {
        if let errorValidation = ValidationsModel.shared.validateInput(emailOrPhone, of: .email(.default)) {
            let messageEmail = errorValidation.reason
            return messageEmail
        }
        return ""
    }
    
    var phoneError: String {
        if let errorValidationPhone = ValidationsModel.shared.validateInput(emailOrPhone, of: .phone(.default)) {
            let messagePhone = errorValidationPhone.reason
            return messagePhone
        }
        return ""
    }
}
