//
//  CreateAccountViewModel_Test.swift
//  petJournal_Tests
//
//  Created by Marcylene Barreto on 06/06/23.
//

import XCTest
@testable import petJournal

final class CreateAccountViewModel_Test: XCTestCase {

    var registerViewModel: CreateAccountViewModel!
    var mockService: RegisterService!
    
    let email = "test@email.com"
    let password = "password"
    
    override func setUp() {
        super.setUp()
        mockService = RegisterService()
        registerViewModel = CreateAccountViewModel(service: mockService)
    }

    func testRegisterUser_Success() {
        
    }
    
    func testRegisterUser_Failure() {
        
    }
}
