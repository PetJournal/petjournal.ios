//
//  CreateAccountViewModel.swift
//  petJournal
//
//  Created by Daiane Goncalves on 12/04/23.
//

import Foundation

final class CreateAccountViewModel: ObservableObject {
    @Published var states: RegisterState = .unknown
    @Published var error: RegisterError = .register
    @Published var user: UserModel = UserModel.newUser
    @Published var userSession: UserSession = .init()
    @Published var cancel: Bool = false
    @Published var isCheckBox = false
    
    var service: CreateAccountServiceProtocol!
    init(service: CreateAccountServiceProtocol) {
        self.service = service
    }
    
    func registerUser() {
        if completeRegister {
            service.registerUser(userModel: user) { result in
                switch result {
                case .success:
                    let sessionModel = SessionModel(userToken: self.user.firstName, model: self.user)
                    self.states = .success
                    self.error = .register
                    self.cancel.toggle()
                case .failure(let failure):
                    switch failure {
                    case .errorRegister:
                        self.states = .failure
                        self.error = .none
                        self.cancel.toggle()
                    case .error:
                        self.error = .none
                        self.cancel.toggle()
                    }
                }
            }
        } else {
            
        }
    }
}

extension CreateAccountViewModel {
    var completeRegister: Bool {
        if isCheckBox &&
            isValidName &&
            isValidEmail &&
            isValidLastname &&
            isValidPassword &&
            isValidPasswordMatch {
            return true
        }
        return false
    }
    
    var emailJaRegistradoAction: Bool {
        if userSession.email == user.email {
            return true
        }
        return false
    }
    
    var emailJaRegistrado: String {
        if userSession.email == user.email {
            return "Registro não realizado, email já cadastrado."
        }
        return "Registro realizado, faça login para acessar."
    }
    
    var isValidPassword: Bool {
        ValidationsModel.shared.validateInput(user.password, of: .password(.default)) == nil
    }
    
    var isValidPasswordMatch: Bool {
        let passMatch = ValidationsModel.shared.validateInput(user.passwordConfirmation, of: .passMatch(.default)) == nil
        if user.password == user.passwordConfirmation {
            if passMatch {
                return true
            }
        }
        return false
    }
    
    var isValidName: Bool {
        ValidationsModel.shared.validateInput(user.firstName, of: .name(.default)) == nil
    }
    
    var isValidLastname: Bool {
        ValidationsModel.shared.validateInput(user.lastName, of: .lastName(.default)) == nil
    }
    
    var isValidPhone: Bool {
        let phoneValid = ValidationsModel.shared.validateInput(user.phone, of: .phone(.default)) == nil
        if user.phone.isEmpty {
            if phoneValid {
                return true
            }
        }
        return false
    }
    
    var isValidEmail: Bool {
        ValidationsModel.shared.validateInput(user.email, of: .email(.default)) == nil
    }
    
    var firstNameErrorMessage: String {
        if let errorValidation = ValidationsModel.shared.validateInput(user.firstName, of: .name(.default)) {
            let message = errorValidation.reason
            return message
        }
        return String()
    }
    
    var lastNameErrorMessage: String {
        if let errorValidation = ValidationsModel.shared.validateInput(user.lastName, of: .lastName(.default)) {
            let message = errorValidation.reason
            return message
        }
        return String()
    }
    
    var emailErrorMessage: String {
        if let errorValidation = ValidationsModel.shared.validateInput(user.email, of: .email(.default)) {
            let message = errorValidation.reason
            return message
        }
        return String()
    }
    
    var phoneErrorMessage: String {
        if let errorValidation = ValidationsModel.shared.validateInput(user.phone, of: .phone(.default)) {
            if !user.phone.isEmpty {
                let message = errorValidation.reason
                return message
            }
        }
        return String()
    }
    
    var messageErrorPassword: String {
        if let errorValidation = ValidationsModel.shared.validateInput(user.password, of: .password(.default)) {
            let message = errorValidation.reason
            return message
        }
        return String()
    }
    
    var messageErrorPasswordMatch: String {
        if let errorValidation = ValidationsModel.shared.validateInput(user.passwordConfirmation, of: .passMatch(.default)) {
            if user.password != user.passwordConfirmation {
                let message = errorValidation.reason
                return message
            }
        }
        return String()
    }
}
