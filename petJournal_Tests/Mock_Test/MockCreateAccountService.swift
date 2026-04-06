@testable import petJournal

final class MockCreateAccountService: CreateAccountServiceProtocol {

    var signUpSuccess: Bool = false
    var error: Error?
    var isRegister: Bool = false
    var registerUserCallCount = 0
    var lastUserModel: UserModel?
    
    init(signUpSuccess: Bool = false, error: Error? = nil) {
        self.signUpSuccess = signUpSuccess
        self.error = error
    }
    
    func registerUser(model: UserModel) async throws -> Bool {
        registerUserCallCount += 1
        lastUserModel = model
        
        if let error = error {
            throw error
        }
        
        if signUpSuccess {
            isRegister = true
            return true
        } else {
            throw NetworkError.badRequest
        }
    }
    
    // MARK: - Test Helper Methods
    func reset() {
        registerUserCallCount = 0
        lastUserModel = nil
        isRegister = false
        error = nil
        signUpSuccess = false
    }
    
    func simulateSuccess() {
        signUpSuccess = true
        error = nil
    }
    
    func simulateFailure(with error: Error = NetworkError.badRequest) {
        signUpSuccess = false
        self.error = error
    }
    
    func simulateConflictError() {
        signUpSuccess = false
        error = NetworkError.conflict
    }
    
    func simulateNetworkError() {
        signUpSuccess = false
        error = NetworkError.serverError
    }
}
