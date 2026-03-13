import XCTest
@testable import petJournal

final class CreateAccountViewModel_Test: XCTestCase {

    var viewModel: CreateAccountViewModel!
    var mockService: MockCreateAccountService!
    
    @MainActor
    override func setUp() {
        super.setUp()
        mockService = MockCreateAccountService()
        viewModel = CreateAccountViewModel(service: mockService)
    }
    
    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    // MARK: - Registration Tests
    @MainActor
    func test_registerUser_success() async {
        // Given
        mockService.simulateSuccess()
        setupValidUser()
        viewModel.isCheckBox = true
        
        // When
        await viewModel.registerUser()
        
        // Then
        XCTAssertTrue(viewModel.isRegister)
        XCTAssertTrue(viewModel.cancel)
        XCTAssertTrue(viewModel.showAlert)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    @MainActor
    func test_registerUser_failure() async {
        // Given
        mockService.simulateFailure()
        setupValidUser()
        viewModel.isCheckBox = true
        
        // When
        await viewModel.registerUser()
        
        // Then
        XCTAssertFalse(viewModel.isRegister)
        XCTAssertTrue(viewModel.cancel)
        XCTAssertTrue(viewModel.showAlert)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.errorMessage)
    }
    
    @MainActor
    func test_registerUser_incompleteData_shouldNotRegister() async {
        // Given
        mockService.simulateSuccess()
        // User with incomplete data (empty fields)
        viewModel.isCheckBox = false
        
        // When
        await viewModel.registerUser()
        
        // Then
        XCTAssertFalse(viewModel.isRegister)
        XCTAssertFalse(viewModel.cancel)
        XCTAssertFalse(viewModel.showAlert)
        XCTAssertFalse(viewModel.isLoading)
    }
    
    // MARK: - Validation Tests
    @MainActor
    func test_completeRegister_withValidData_shouldReturnTrue() {
        // Given
        setupValidUser()
        viewModel.isCheckBox = true
        
        // Then
        XCTAssertTrue(viewModel.completeRegister)
    }
    
    @MainActor
    func test_completeRegister_withInvalidData_shouldReturnFalse() {
        // Given
        viewModel.user.firstName = "Jo" // Invalid (too short)
        viewModel.user.email = "invalid-email" // Invalid format
        viewModel.isCheckBox = true
        
        // Then
        XCTAssertFalse(viewModel.completeRegister)
    }
    
    @MainActor
    func test_completeRegister_withoutCheckbox_shouldReturnFalse() {
        // Given
        setupValidUser()
        viewModel.isCheckBox = false
        
        // Then
        XCTAssertFalse(viewModel.completeRegister)
    }
    
    // MARK: - Individual Validation Tests
    @MainActor
    func test_isValidName_withValidName_shouldReturnTrue() {
        // Given
        viewModel.user.firstName = "Maria"
        
        // Then
        XCTAssertTrue(viewModel.isValidName)
    }
    
    @MainActor
    func test_isValidName_withInvalidName_shouldReturnFalse() {
        // Given
        viewModel.user.firstName = "Jo"
        
        // Then
        XCTAssertFalse(viewModel.isValidName)
    }
    
    @MainActor
    func test_isValidEmail_withValidEmail_shouldReturnTrue() {
        // Given
        viewModel.user.email = "test@example.com"
        
        // Then
        XCTAssertTrue(viewModel.isValidEmail)
    }
    
    @MainActor
    func test_isValidEmail_withInvalidEmail_shouldReturnFalse() {
        // Given
        viewModel.user.email = "invalid-email"
        
        // Then
        XCTAssertFalse(viewModel.isValidEmail)
    }
    
    @MainActor
    func test_isValidPassword_withValidPassword_shouldReturnTrue() {
        // Given
        viewModel.user.password = "Password123!"
        
        // Then
        XCTAssertTrue(viewModel.isValidPassword)
    }
    
    @MainActor
    func test_isValidPassword_withInvalidPassword_shouldReturnFalse() {
        // Given
        viewModel.user.password = "weak"
        
        // Then
        XCTAssertFalse(viewModel.isValidPassword)
    }
    
    @MainActor
    func test_isValidPasswordMatch_withMatchingPasswords_shouldReturnTrue() {
        // Given
        viewModel.user.password = "Password123!"
        viewModel.user.passwordConfirmation = "Password123!"
        
        // Then
        XCTAssertTrue(viewModel.isValidPasswordMatch)
    }
    
    @MainActor
    func test_isValidPasswordMatch_withNonMatchingPasswords_shouldReturnFalse() {
        // Given
        viewModel.user.password = "Password123!"
        viewModel.user.passwordConfirmation = "DifferentPassword123!"
        
        // Then
        XCTAssertFalse(viewModel.isValidPasswordMatch)
    }
    
    // MARK: - Error Message Tests
    @MainActor
    func test_registrationStatusMessage_onSuccess() {
        // Given
        viewModel.isRegister = true
        
        // Then
        XCTAssertEqual(viewModel.registrationStatusMessage, "Registro realizado, faça login para acessar.")
    }
    
    @MainActor
    func test_registrationStatusMessage_onFailure() {
        // Given
        viewModel.isRegister = false
        viewModel.errorMessage = "Erro customizado"
        
        // Then
        XCTAssertEqual(viewModel.registrationStatusMessage, "Erro customizado")
    }
    
    @MainActor
    func test_registrationStatusMessage_onFailureWithoutError() {
        // Given
        viewModel.isRegister = false
        viewModel.errorMessage = nil
        
        // Then
        XCTAssertEqual(viewModel.registrationStatusMessage, "Preencha corretamente todos os campos.")
    }
    
    // MARK: - Error Handling Tests
    @MainActor
    func test_handleRegistrationError_conflictError() async {
        // Given
        mockService.simulateConflictError()
        setupValidUser()
        viewModel.isCheckBox = true
        
        // When
        await viewModel.registerUser()
        
        // Then
        XCTAssertFalse(viewModel.isRegister)
        XCTAssertTrue(viewModel.cancel)
        XCTAssertTrue(viewModel.showAlert)
        XCTAssertEqual(viewModel.errorMessage, "Email ou telefone já cadastrado. Faça login para acessar.")
    }
    
    @MainActor
    func test_handleRegistrationError_networkError() async {
        // Given
        mockService.simulateNetworkError()
        setupValidUser()
        viewModel.isCheckBox = true
        
        // When
        await viewModel.registerUser()
        
        // Then
        XCTAssertFalse(viewModel.isRegister)
        XCTAssertTrue(viewModel.cancel)
        XCTAssertTrue(viewModel.showAlert)
        XCTAssertEqual(viewModel.errorMessage, "Erro na comunicação com o servidor. Tente novamente mais tarde.")
    }
    
    // MARK: - Helper Methods
    @MainActor
    private func setupValidUser() {
        viewModel.user.firstName = "Maria"
        viewModel.user.lastName = "Silva"
        viewModel.user.email = "maria@example.com"
        viewModel.user.password = "Password123!"
        viewModel.user.passwordConfirmation = "Password123!"
        viewModel.user.phone = "11987654321"
    }
}
