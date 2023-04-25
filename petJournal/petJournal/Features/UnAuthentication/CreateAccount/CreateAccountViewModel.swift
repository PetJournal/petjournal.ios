//
//  CreateAccountViewModel.swift
//  petJournal
//
//  Created by Daiane Goncalves on 12/04/23.
//

import Foundation

class CreateAccountViewModel {
    

    func isValidName (value: String) -> String? {
        let regularExpression = "^[A-Za-z]{3,}.*+$"
        let namePredicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        if !namePredicate.evaluate(with: value){
            return "Nome inválido"
        }
        if value.count < 3  {
            return "O nome deve ter pelo menos 3 caracteres"
        }
        return nil
    }
    
    func isValidEmail (value: String) -> String? {
        let regularExpression = #"^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$"#
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        if !emailPredicate.evaluate(with: value){
            return "E-mail inválido"
        }
        return nil
    }
    
    func isValidPassword (value: String) -> String? {
        if value.count < 8 {
            return "A senha deve ter pelo menos 8 caracteres. Para torná-la mais forte, use letras maiúsculas e minúsculas, números e símbolos como ! @ # $ % & * ="
        }
        if containsDigit(value) {
            return "A senha deve ter pelo menos 1 caractere alfanumérico"
        }
        if containsEspecial(value) {
            return "A senha deve ter pelo menos 1 caractere especial"
        }
        return nil
    }
    
    func containsDigit(_ value: String) -> Bool {
        let regularExpression = "^(?=.*[A-Za-z0-9])(?=.*[0-9]).*$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return !passwordPredicate.evaluate(with: value)
    }
    
    func containsEspecial(_ value: String) -> Bool {
        let regularExpression = "^(?=.*[!@#$%^&*()_+={};':\\|,.<>/?-]).*$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", regularExpression)
        return !passwordPredicate.evaluate(with: value)
    }
    
    func isValidPhone(_ value: String) -> String? {
        if value.count < 11 {
            return "Campo inválido"
        }
        if value.count > 11 {
            let truncatedPhoneNumber = value.prefix(11)
        }
        return nil
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

extension CreateAccountViewModel {
    
    func getMockUserPJModel () -> UserPJModel {
        let model = UserPJModel(name: "Eistein", lastName: "Silva", email: "ssa@fd.com", phoneNumber: "21312123")
        return model
    }
    
}
