import XCTest
@testable import petJournal

final class AccessAccountViewModel_Test: XCTestCase {

    var viewModel: AccessAccountViewModel!
    var mockService: MockAccessAccountService!
    
    @MainActor
    override func setUp() {
        super.setUp()
        mockService = MockAccessAccountService()
        // viewModel = AccessAccountViewModel(service: mockService)
        // Uncomment when AccessAccountViewModel is ready to accept service injection
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    // MARK: - MockAccessAccountService Functionality Tests
    func test_mockAccessAccountService_successScenario() async throws {
        // Given
        mockService.simulateSuccess(withToken: "custom_token_123")
        
        // When
        let token = try await mockService.authenticationEmail(email: "test@example.com", password: "password123")
        
        // Then
        XCTAssertEqual(token, "custom_token_123")
        XCTAssertTrue(mockService.isLogged)
        XCTAssertEqual(mockService.authenticationCallCount, 1)
        XCTAssertEqual(mockService.lastEmailUsed, "test@example.com")
        XCTAssertEqual(mockService.lastPasswordUsed, "password123")
    }
    
    func test_mockAccessAccountService_invalidCredentialsScenario() async {
        // Given
        mockService.simulateInvalidCredentials()
        
        // When & Then
        do {
            _ = try await mockService.authenticationEmail(email: "wrong@example.com", password: "wrongpass")
            XCTFail("Should have thrown an error")
        } catch let error as AuthenticationError {
            XCTAssertEqual(error, AuthenticationError.invalidCredentials)
            XCTAssertFalse(mockService.isLogged)
            XCTAssertEqual(mockService.authenticationCallCount, 1)
        } catch {
            XCTFail("Wrong error type thrown")
        }
    }
    
    func test_mockAccessAccountService_networkErrorScenario() async {
        // Given
        mockService.simulateNetworkError()
        
        // When & Then
        do {
            _ = try await mockService.authenticationEmail(email: "test@example.com", password: "password123")
            XCTFail("Should have thrown an error")
        } catch let error as NetworkError {
            // Check if it's the expected NetworkError type
            switch error {
            case .serverError:
                XCTAssertTrue(true) // Expected error type
            default:
                XCTFail("Expected NetworkError.serverError, got \(error)")
            }
            XCTAssertFalse(mockService.isLogged)
        } catch {
            XCTFail("Wrong error type thrown: \(error)")
        }
    }
    
    func test_mockAccessAccountService_unauthorizedErrorScenario() async {
        // Given
        mockService.simulateUnauthorizedError()
        
        // When & Then
        do {
            _ = try await mockService.authenticationEmail(email: "test@example.com", password: "password123")
            XCTFail("Should have thrown an error")
        } catch let error as NetworkError {
            switch error {
            case .unauthorized:
                XCTAssertTrue(true) // Expected error type
            default:
                XCTFail("Expected NetworkError.unauthorized, got \(error)")
            }
            XCTAssertFalse(mockService.isLogged)
        } catch {
            XCTFail("Wrong error type thrown: \(error)")
        }
    }
    
    func test_mockAccessAccountService_invalidResponseScenario() async {
        // Given
        mockService.simulateInvalidResponse()
        
        // When & Then
        do {
            _ = try await mockService.authenticationEmail(email: "test@example.com", password: "password123")
            XCTFail("Should have thrown an error")
        } catch let error as AuthenticationError {
            XCTAssertEqual(error, AuthenticationError.invalidResponse)
            XCTAssertFalse(mockService.isLogged)
        } catch {
            XCTFail("Wrong error type thrown: \(error)")
        }
    }
    
    func test_mockAccessAccountService_unknownErrorScenario() async {
        // Given
        mockService.simulateUnknownError()
        
        // When & Then
        do {
            _ = try await mockService.authenticationEmail(email: "test@example.com", password: "password123")
            XCTFail("Should have thrown an error")
        } catch let error as AuthenticationError {
            XCTAssertEqual(error, AuthenticationError.unknown)
            XCTAssertFalse(mockService.isLogged)
        } catch {
            XCTFail("Wrong error type thrown: \(error)")
        }
    }
    
    func test_mockAccessAccountService_multipleCallsTracking() async throws {
        // Given
        mockService.simulateSuccess()
        
        // When
        _ = try await mockService.authenticationEmail(email: "user1@example.com", password: "pass1")
        _ = try await mockService.authenticationEmail(email: "user2@example.com", password: "pass2")
        
        // Then
        XCTAssertEqual(mockService.authenticationCallCount, 2)
        XCTAssertEqual(mockService.lastEmailUsed, "user2@example.com") // Last call
        XCTAssertEqual(mockService.lastPasswordUsed, "pass2") // Last call
    }
    
    func test_mockAccessAccountService_resetFunctionality() async throws {
        // Given
        mockService.simulateSuccess()
        _ = try await mockService.authenticationEmail(email: "test@example.com", password: "password123")
        
        // When
        mockService.reset()
        
        // Then
        XCTAssertEqual(mockService.authenticationCallCount, 0)
        XCTAssertNil(mockService.lastEmailUsed)
        XCTAssertNil(mockService.lastPasswordUsed)
        XCTAssertFalse(mockService.isLogged)
        XCTAssertFalse(mockService.signInSuccess)
        XCTAssertNil(mockService.error)
    }
    
    func test_mockAccessAccountService_customTokenConfiguration() async throws {
        // Given
        let customToken = "jwt_token_abc123xyz"
        mockService.simulateSuccess(withToken: customToken)
        
        // When
        let token = try await mockService.authenticationEmail(email: "test@example.com", password: "password123")
        
        // Then
        XCTAssertEqual(token, customToken)
        XCTAssertEqual(mockService.tokenToReturn, customToken)
    }
}