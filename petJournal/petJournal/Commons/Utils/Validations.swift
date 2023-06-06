//
//  Validations.swift
//  petJournal
//
//  Created by Marcylene Barreto on 17/04/23.
//

import Foundation

class Validations {
    static var shared = Validations()
    
    func validFieldsLogin(_ email: String,
                          password: String) -> Bool {
        return isValidEmail(email) && isValidPassword(password)
    }
    
    func validFieldsRegister(_ name: String,
                             email: String,
                             phone: String,
                             password: String) -> Bool {
        return isValidPhone(phone) && isValidName(value: name) && isValidEmail(email) && isValidPassword(password)
    }
    
    func isValidPassword(_ password: String) -> Bool {
        if isEmptyValue(password) && validateQuantityPassword(password) {
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
    
    private func validateQuantityPassword(_ password: String?) -> Bool  {
        guard let password = password else { return false }
        return password.count > 8
    }
    
    private func isEmptyValue(_ value: String) -> Bool {
        return !value.isEmpty
    }
    
    func validEmail(_ email: String) -> Bool {
        if isValidEmail(email) && isEmptyValue(email) {
            return true
        }
        return false
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func matchPasswords(_ passwordMatch: String, pass: String) -> Bool {
        if passwordMatch == pass && isValidPassword(passwordMatch) {
            return true
        }
        return false
    }
    
    // Register
    
    private func isValidName(value: String) -> Bool {
        let regularExpression = "^[A-Za-z]{3,}.*+$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return namePredicate.evaluate(with: value)
    }
    
    func isValidPhone(_ value: String) -> Bool {
        if value.count < 11 {
            return true
        }
        if value.count > 11 {
            let truncatedPhoneNumber = value.prefix(11)
        }
        return false
    }
    
    func isformatPhoneNumber(_ phoneNumber: String) -> String {
        let cleanPhoneNumber = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        let mask = "(##) # ####-####"
        var result = ""
        var index = cleanPhoneNumber.startIndex
        
        for ch in mask where index < cleanPhoneNumber.endIndex {
            if ch == "#" {
                result.append(cleanPhoneNumber[index])
                index = cleanPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}


