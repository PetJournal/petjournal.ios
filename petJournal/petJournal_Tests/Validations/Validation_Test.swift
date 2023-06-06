//
//  Validation_Test.swift
//  petJournal_Tests
//
//  Created by Marcylene Barreto on 26/04/23.
//

import XCTest
@testable import petJournal

final class Validation_Test: XCTestCase {
    
    func testEmailCorrect() {
        let email = "mar@gmail.com"
        let validation = Validations.shared.validEmail(email)
        XCTAssertTrue(validation)
    }
    
    func testEmailIncorrect() {
        let incorrectEmail = "mar@gmail"
        let validation = Validations.shared.validEmail(incorrectEmail)
        XCTAssertFalse(validation)
    }
    
    func testPasswordCorrect() {
        let correctPass = "password123"
        let validation = Validations.shared.isValidPassword(correctPass)
        XCTAssertTrue(validation)
    }
    
    func testPasswordInvalid() {
        let incorrectPass = "pass"
        let validation = Validations.shared.isValidPassword(incorrectPass)
        XCTAssertFalse(validation)
    }
    
    func testLoginFields_Success() {
        let email = "mar@gmail.com"
        let password = "password123"
        XCTAssertTrue(Validations.shared.validFieldsLogin(email, password: password))
    }
    
    func testLoginFields_Failure() {
        let email = "mar@gmail"
        let password = "pass"
        XCTAssertFalse(Validations.shared.validFieldsLogin(email, password: password))
    }
    
    func testRegisterFields_Success() {
        let name = "Ivo"
        let phone = "19999999999"
        let email = "mar@gmail.com"
        let password = "password123"
        XCTAssertTrue(Validations.shared.validFieldsLogin(email, password: password))
    }
    
    func testRegisterFields_Failure() {
        let name = "Io"
        let phone = "19999"
        let email = "mar@gmail"
        let password = "pass"
        XCTAssertFalse(Validations.shared.validFieldsRegister(name, email: email, phone: phone, password: password))
    }
}
