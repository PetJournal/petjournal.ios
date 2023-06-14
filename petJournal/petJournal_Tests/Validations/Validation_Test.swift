//
//  Validation_Test.swift
//  petJournal_Tests
//
//  Created by Marcylene Barreto on 26/04/23.
//

import XCTest
@testable import petJournal

final class Validation_Test: XCTestCase {
    
    func test_whenTheEmailIsCorrectFormat() {
        let email = "mar@gmail.com"
        let validation = Validations.shared.validEmail(email)
        XCTAssertTrue(validation)
    }
    
    func test_whenTheEmailIsIncorrectFormat() {
        let incorrectEmail = "mar@gmail"
        let validation = Validations.shared.validEmail(incorrectEmail)
        XCTAssertFalse(validation)
    }
    
    func test_passwordCorrectFormat() {
        let correctPass = "password123"
        let validation = Validations.shared.isValidPassword(correctPass)
        XCTAssertTrue(validation)
    }
    
    func test_passwordIncorrectFormat() {
        let incorrectPass = "pass"
        let validation = Validations.shared.isValidPassword(incorrectPass)
        XCTAssertFalse(validation)
    }
    
    func test_whenLoginData_areCorrect() {
        let email = "mar@gmail.com"
        let password = "password123"
        XCTAssertTrue(Validations.shared.validFieldsLogin(email, password: password))
    }
    
    func test_whenLoginData_areIncorrect() {
        let email = "mar@gmail"
        let password = "pass"
        XCTAssertFalse(Validations.shared.validFieldsLogin(email, password: password))
    }
    
    func test_whenRegisterData_areCorrect() {
        let name = "Mar"
        let phone = "19999999999"
        let email = "mar@gmail.com"
        let password = "password123"
        XCTAssertTrue(Validations.shared.validFieldsRegister(name, email: email, phone: phone, password: password))
    }

    func test_whenRegisterData_areIncorrect() {
        let name = "Io"
        let phone = "19999"
        let email = "mar@gmail"
        let password = "pass"
        XCTAssertFalse(Validations.shared.validFieldsRegister(name, email: email, phone: phone, password: password))
    }
}
