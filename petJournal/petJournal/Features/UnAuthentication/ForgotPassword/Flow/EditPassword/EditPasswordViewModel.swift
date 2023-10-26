//
//  EditPasswordViewModel.swift
//  petJournal
//
//  Created by Marcylene Barreto on 14/06/23.
//

import SwiftUI

final class EditPasswordViewModel: ObservableObject {
    @Published var user: UserModel = .newUser
    @Published var userSession: UserSession = .init()
    @Published var cancel: Bool = false
    @Published var isCheckBox = false
    @Published var activeError: LocalizedError?

    var isPresentingAlert: Binding<Bool> {
        return Binding<Bool>(get: {
            return self.activeError != nil
        }, set: { newValue in
            guard !newValue else { return }
            self.activeError = nil
        })
    }
    
    func showAlertView() {
        passwordCheckError()
    }
    
    func editPassword(value: String) {
        if passwordCheck {
            UserDefaultsUtils.save(value: value, key: KeysUser.email.rawValue)
            self.cancel.toggle()
        } else {
            passwordCheckError()
        }
    }
}

extension EditPasswordViewModel {
    var passwordCheck: Bool {
        if matchPass &&
            isValidPassword {
            return true
        }
        return false
    }
    
    func passwordCheckError() {
        if user.password.isEmpty || user.passwordMatch.isEmpty {
            activeError = EditPasswordError.isEmptyValue
        } else if !isValidPassword {
            activeError = EditPasswordError.incorrectPassword
        } else if !matchPass {
            activeError = EditPasswordError.noMatchPassword
        }
    }
      
    var matchPass: Bool {
        let passMatch = ValidationsModel.shared.validateInput(user.passwordMatch, of: .passMatch(.default)) == nil
        if user.password == user.passwordMatch {
            if passMatch {
                return true
            }
        }
        return false
    }
    
    var isValidPassword: Bool {
        ValidationsModel.shared.validateInput(user.password, of: .password(.default)) == nil
    }
    
    var messageErrorPassword: String {
        if let errorValidation = ValidationsModel.shared.validateInput(user.password, of: .password(.default)) {
            let message = errorValidation.reason
            return message
        }
        return String()
    }
    
    var messageErrorPasswordMatch: String {
        if let errorValidation = ValidationsModel.shared.validateInput(user.passwordMatch, of: .passMatch(.default)) {
            if user.password != user.passwordMatch {
                let message = errorValidation.reason
                return message
            }
        }
        return String()
    }
    
    var resetPasswordAction: Bool {
        if !(userSession.password == user.password) {
            return true
        }
        return false
    }
}

enum EditPasswordError: LocalizedError {
    case incorrectPassword
    case noMatchPassword
    case isEmptyValue
    
    var errorDescription: String? {
        switch self {
        case .incorrectPassword:
            return "editpassword-password-error".localized
        case .noMatchPassword:
            return "editpassword-empty-error".localized
        case .isEmptyValue:
            return "editpassword-empty-error".localized
        }
    }
    
    var failureReason: String? {
        switch self {
        case .incorrectPassword:
            return "editpassword-password-fail".localized
        case .noMatchPassword:
            return "editpassword-match-fail".localized
        case .isEmptyValue:
            return "editpassword-empty-fail".localized
        }
    }
}
