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
    var mockService: SpyRegisterService
    var usermodel: UserModel
    
    init(registerViewModel: CreateAccountViewModel, mockService: SpyRegisterService, usermodel: UserModel) {
        self.registerViewModel = registerViewModel
        self.mockService = mockService
        self.usermodel = usermodel
        super.init()
    }
    
    override func setUp() {
        super.setUp()
        mockService = SpyRegisterService()
        registerViewModel = CreateAccountViewModel(service: mockService)
    }

    func testRegisterUser_Success() {
        mockService.signUpSuccess = true
        registerViewModel.registerUser()
        XCTAssertEqual(RegisterStatus.success, registerViewModel.states)
    }
    
    func testRegisterUser_Failure() {
        mockService.signUpSuccess = false
        registerViewModel.registerUser()
        XCTAssertEqual(RegisterStatus.failure, registerViewModel.states)
    }
}
