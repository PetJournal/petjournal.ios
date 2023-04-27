//
//  AccessAccountViewModel_Test.swift
//  petJournal_Tests
//
//  Created by Marcylene Barreto on 26/04/23.
//

import XCTest
@testable import petJournal

final class AccessAccountViewModel_Test: XCTestCase {

    var authViewModel: AccessAccountViewModel!
    var mockService: AuthMock!
    
    let email = "test@email.com"
    let password = "password"
    
    override func setUp() {
        super.setUp()
        mockService = AuthMock()
        authViewModel = AccessAccountViewModel(service: mockService)
    }
    
    func testSignInUser_Success() {
        mockService.signInSuccess = true
        authViewModel.authUser(email, pass: password)
        XCTAssertEqual(SignState.signedIn, authViewModel.singState.value)
    }
    
    func testSignInUser_Failure() {
        mockService.signInSuccess = false
        mockService.error = ErrorApp.errorAuthentication
        authViewModel.authUser(email, pass: password)
        XCTAssertEqual(SignState.signedOut, authViewModel.singState.value)
    }
}
