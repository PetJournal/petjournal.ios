//
//  EditPasswordViewModel.swift
//  petJournal
//
//  Created by Marcylene Barreto on 15/05/23.
//

import Foundation

enum EditError: Error {
    case noMatch
    case confirm
}

class EditPasswordViewModel: ObservableObject {
    @Published var user: UserModel = UserModel.newUser
    @Published var error: EditError = .noMatch
    @Published var cancel: Bool = false
    
    var passwordCheck: Bool {
        if !user.password.isEmpty && !user.passwordMatch.isEmpty {
            return false
        }
        return true
    }
    
    var passwordSemelhante: Bool {
        if !Validations.shared.passwordMatch(user.passwordMatch) {
            return false
        }
        return true
    }
    
    func checkMatchPassword() {
        if !passwordSemelhante {
            error = .confirm
        } else {
            error = .noMatch
            cancel.toggle()
        }
    }
}
