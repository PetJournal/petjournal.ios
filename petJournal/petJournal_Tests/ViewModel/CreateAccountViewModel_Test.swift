//
//  CreateAccountViewModel_Test.swift
//  petJournal_Tests
//
//  Created by Marcylene Barreto on 06/06/23.
//

import XCTest
@testable import petJournal

final class CreateAccountViewModel_Test: XCTestCase {

    var registerViewModel: CreateAccountViewModel
    var mockService: RegisterService
    var usermodel: UserModel
    
    init(registerViewModel: CreateAccountViewModel, mockService: RegisterService, usermodel: UserModel) {
        self.registerViewModel = registerViewModel
        self.mockService = mockService
        self.usermodel = usermodel
        super.init()
    }
    
    override func setUp() {
        super.setUp()
        mockService = RegisterService()
        registerViewModel = CreateAccountViewModel(service: mockService)
    }

    func testRegisterUser_Success() {
        mockService.signUpSuccess = true
        registerViewModel.registerUser()
        XCTAssertEqual(RegisterState.success, registerViewModel.states)
    }
    
    func testRegisterUser_Failure() {
        mockService.signUpSuccess = false
        registerViewModel.registerUser()
        XCTAssertEqual(RegisterState.failure, registerViewModel.states)
    }
}
