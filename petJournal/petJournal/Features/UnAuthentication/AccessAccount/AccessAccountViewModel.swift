//
//  AccessAccountViewModel.swift
//  petJournal
//
//  Created by Marcylene Barreto on 24/03/23.
//

import Foundation
import UIKit
import Combine

struct AccessAccountViewModel {
    func validFields(_ username: AnyPublisher<String?, Never>,
                     password: AnyPublisher<String?, Never>) -> AnyPublisher<Bool, Never> {
        validUsername(username)
            .combineLatest(validPassword(password))
            .map({ (validUsername, validPassword) in
                return !(validUsername && validPassword)
            })
            .eraseToAnyPublisher()
    }
    
    func validPassword(_ password: AnyPublisher<String?, Never>) -> AnyPublisher<Bool, Never> {
        password.map { isValidPassword($0) }
            .eraseToAnyPublisher()
    }
    
    private func isValidPassword(_ password: String?) -> Bool {
        guard let password = password else { return false }
        return password.count >= 8
    }
    
    func validUsername(_ username: AnyPublisher<String?, Never>) -> AnyPublisher<Bool, Never> {
        username.map { value in
            isValidEmail(value)
        }
        .eraseToAnyPublisher()
    }
    
    private func isValidEmail(_ email: String?) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func textFieldsErrorMsg(_ email: AnyPublisher<String?, Never>,
                            password: AnyPublisher<String?, Never>) -> AnyPublisher<ErrorAuth, Never> {
        validFields(email, password: password)
            .map({ value in
                value ? .invalidInput : .blank
            })
            .eraseToAnyPublisher()
    }
    
}
