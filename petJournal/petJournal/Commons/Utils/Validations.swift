//
//  Validations.swift
//  petJournal
//
//  Created by Marcylene Barreto on 17/04/23.
//

import Foundation

class Validations {
    func validFields(_ email: String,
                     password: String) -> Bool {
        if isValidEmail(email) && isValidPassword(password) {
            return true
        }
        return false
    }
    
    func isValidPassword(_ password: String) -> Bool {
        if validPassword(password) {
            return true
        }
        return false
    }
    
    private func validPassword(_ password: String) -> Bool {
        let passwordValid = "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{6,16}"
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordValid)
        let result = passwordPredicate.evaluate(with: password)
        return result
    }
    
    func validateQuantityPassword(_ password: String?) -> Bool  {
        guard let password = password else { return false }
        return password.count < 8
    }
    
    func validEmail(_ email: String) -> Bool {
        if isValidEmail(email) {
            return true
        }
        return false
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
