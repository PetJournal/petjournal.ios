//
//  CreateAccountViewModel.swift
//  petJournal
//
//  Created by Daiane Goncalves on 12/04/23.
//

import Foundation

class CreateAccountViewModel: ObservableObject {
    @Published var states: RegisterState = .unknown
    @Published var error: RegisterError = .register
    @Published var user: UserModel = UserModel.newUser
    @Published var cancel: Bool = false
    
    var service: CreateAccountServiceProtocol!
    init(service: CreateAccountServiceProtocol) {
        self.service = service
    }
    
    func registerUser() {
        if completeRegister {
            service.registerUser(userModel: user) { result in
                switch result {
                case .success:
                    self.states = .success
                    let sessionModel = SessionModel(userName: self.user.name, model: self.user)
                    SessionManager.shared.updateValidation(with: sessionModel)
                case .failure(let failure):
                    self.states = .failure
                    print("Error \(failure.localizedDescription)")
                }
            }
        } else {
            
        }
    }
}

extension CreateAccountViewModel {
    var completeRegister: Bool {
        if !Validations.shared.validFieldsRegister(user.name, email: user.email, phone: user.phoneNumber, password: user.password) && !matchPass {
            return false
        }
        return true
    }
    
    var matchPass: Bool {
        if Validations.shared.matchPasswords(user.passwordMatch, pass: user.password) {
            return true
        }
        return false
    }
}
