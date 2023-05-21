//
//  Validations.swift
//  petJournal
//
//  Created by Marcylene Barreto on 17/04/23.
//

import SwiftUI

struct Validations {
    static var shared = Validations()
    
    var user: UserModel = UserModel.newUser

    func validFields(_ email: String,
                     _ password: String) -> Bool {
        return validEmail(email) && isValidPassword(password)
    }
    
    //Email
    func validEmail(_ email: String) -> Bool {
        if isValidEmail(email) && checkDomainPetjournal(email: email) {
            return true
        }
        return false
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    private func checkDomainPetjournal(email: String) -> Bool {
        return email.contains("@petjournal.com")
    }
    
    //Password
    func isValidPassword(_ password: String) -> Bool {
        if validPassword(password) && numberOfDigits(password) {
            return true
        }
        return false
    }
    
    func passwordMatch(_ confirmPass: String) -> Bool {
        return confirmPass == user.password
    }
    
    private func validPassword(_ password: String) -> Bool {
        let passwordValid = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{6,16}"
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordValid)
        let result = passwordPredicate.evaluate(with: password)
        return result
    }
    
    private func numberOfDigits(_ password: String?) -> Bool  {
        guard let password = password else { return false }
        return password.count > 8
    }
}
