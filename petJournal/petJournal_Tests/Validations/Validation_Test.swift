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
        let email = "mar@petjournal.com"
        let validation = Validations.shared.validEmail(email)
        XCTAssertTrue(validation)
    }
    
    func testEmailIncorrect() {
        let incorrectEmail = "mar@gmail"
        let validation = Validations.shared.validEmail(incorrectEmail)
        XCTAssertFalse(validation)
    }
    
    func testPasswordCorrect() {
        let correctPass = "password@123"
        let validation = Validations.shared.isValidPassword(correctPass)
        XCTAssertTrue(validation)
    }
    
    func testPasswordInvalid() {
        let incorrectPass = "pass"
        let validation = Validations.shared.isValidPassword(incorrectPass)
        XCTAssertFalse(validation)
    }
}
