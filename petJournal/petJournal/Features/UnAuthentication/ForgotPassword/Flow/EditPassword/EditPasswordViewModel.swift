//
//  EditPasswordViewModel.swift
//  petJournal
//
//  Created by Marcylene Barreto on 14/06/23.
//

import Foundation

final class EditPasswordViewModel: ObservableObject {
    @Published var user: UserModel = .newUser
    @Published var userSession: UserSession = .init()
    @Published var cancel: Bool = false

    func editPassword(value: String) {
        if passwordCheck {
            UserDefaultsUtils.save(value: value, key: KeysUser.email.rawValue)
        }
    }
}

extension EditPasswordViewModel {
    var passwordCheck: Bool {
        if !user.password.isEmpty && !user.passwordMatch.isEmpty {
            if matchPass {
                return false
            }
        }
        return true
    }
      
    var matchPass: Bool {
        if !Validations.shared.matchPasswords(user.passwordMatch, pass: user.password) {
            return false
        }
        return true
    }
    
    var invalidPassword: String {
        if user.password.count > 4 {
            if !Validations.shared.isValidPassword(user.password) {
                return "Senha invalida"
            }
        }
        return ""
    }
    
    var errorPasswordMatch: String {
        if user.passwordMatch.count > 4 {
            if !matchPass {
                return "Senhas incompativeis"
            }
        }
        return ""
    }
}
