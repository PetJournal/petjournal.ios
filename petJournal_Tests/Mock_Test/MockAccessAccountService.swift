@testable import petJournal

final class MockAccessAccountService: AccessAccountServiceProtocol {
    
    // MARK: - Configuration Properties
    var signInSuccess: Bool = false
    var error: Error?
    var tokenToReturn: String = "mock_token_12345"
    
    // MARK: - Spy Properties
    var authenticationCallCount = 0
    var lastEmailUsed: String?
    var lastPasswordUsed: String?
    var isLogged: Bool = false
    
    // MARK: - Initialization
    init(signInSuccess: Bool = false, error: Error? = nil, tokenToReturn: String = "mock_token_12345") {
        self.signInSuccess = signInSuccess
        self.error = error
        self.tokenToReturn = tokenToReturn
    }
    
    // MARK: - Protocol Implementation
    func authenticationEmail(email: String, password: String) async throws -> String {
        // Record call for spy functionality
        authenticationCallCount += 1
        lastEmailUsed = email
        lastPasswordUsed = password
        
        // Simulate network delay (optional)
        try await Task.sleep(nanoseconds: 10_000_000) // 0.01 seconds
        
        // Handle custom error if set
        if let error = error {
            throw error
        }
        
        // Handle success/failure scenarios
        if signInSuccess {
            isLogged = true
            return tokenToReturn
        } else {
            throw AuthenticationError.invalidCredentials
        }
    }
    
    // MARK: - Test Helper Methods
    func reset() {
        authenticationCallCount = 0
        lastEmailUsed = nil
        lastPasswordUsed = nil
        isLogged = false
        error = nil
        signInSuccess = false
        tokenToReturn = "mock_token_12345"
    }
    
    func simulateNetworkError() {
        error = NetworkError.serverError
        signInSuccess = false
    }
    
    func simulateInvalidCredentials() {
        error = AuthenticationError.invalidCredentials
        signInSuccess = false
    }
    
    func simulateUnauthorizedError() {
        error = NetworkError.unauthorized
        signInSuccess = false
    }
    
    func simulateInvalidResponse() {
        error = AuthenticationError.invalidResponse
        signInSuccess = false
    }
    
    func simulateUnknownError() {
        error = AuthenticationError.unknown
        signInSuccess = false
    }
    
    func simulateSuccess(withToken token: String = "mock_token_12345") {
        signInSuccess = true
        tokenToReturn = token
        error = nil
    }
    
    func simulateFailure(with error: Error = AuthenticationError.invalidCredentials) {
        signInSuccess = false
        self.error = error
    }
}
