import XCTest
@testable import petJournal

final class Validation_Test: XCTestCase {
    
    // MARK: - Email Validation Tests
    func test_validEmail_shouldPass() {
        let email = "test@example.com"
        XCTAssertNoThrow(try Validations.shared.validate(email, type: .email(.default)))
    }
    
    func test_invalidEmail_shouldThrowError() {
        let email = "invalid-email"
        XCTAssertThrowsError(try Validations.shared.validate(email, type: .email(.default))) { error in
            let validationError = error as! Validations.ValidationError
            XCTAssertEqual(validationError.reason, "Email inválido")
        }
    }
    
    func test_emptyEmail_shouldThrowError() {
        let email = ""
        XCTAssertThrowsError(try Validations.shared.validate(email, type: .email(.default))) { error in
            let validationError = error as! Validations.ValidationError
            XCTAssertEqual(validationError.reason, "Campo é obrigatório")
        }
    }
    
    // MARK: - Password Validation Tests
    func test_validPassword_shouldPass() {
        let password = "Password123!"
        XCTAssertNoThrow(try Validations.shared.validate(password, type: .password(.default)))
    }
    
    func test_invalidPassword_shouldThrowError() {
        let password = "weak"
        XCTAssertThrowsError(try Validations.shared.validate(password, type: .password(.default))) { error in
            let validationError = error as! Validations.ValidationError
            XCTAssertEqual(validationError.reason, "A senha deve ter pelo menos 8 caracteres. Para torná-la mais forte, use letras maiúsculas e minúsculas, números e símbolos como ! @ # $ % & * =")
        }
    }
    
    // MARK: - Name Validation Tests
    func test_validName_shouldPass() {
        let name = "Maria"
        XCTAssertNoThrow(try Validations.shared.validate(name, type: .name(.default)))
    }
    
    func test_invalidName_shouldThrowError() {
        let name = "Jo"
        XCTAssertThrowsError(try Validations.shared.validate(name, type: .name(.default))) { error in
            let validationError = error as! Validations.ValidationError
            XCTAssertEqual(validationError.reason, "O nome inválido.")
        }
    }
    
    // MARK: - Phone Validation Tests
    func test_validPhone_shouldPass() {
        let phone = "11987654321"
        XCTAssertNoThrow(try Validations.shared.validate(phone, type: .phone(.default)))
    }
    
    func test_invalidPhone_shouldThrowError() {
        let phone = "123"
        XCTAssertThrowsError(try Validations.shared.validate(phone, type: .phone(.default))) { error in
            let validationError = error as! Validations.ValidationError
            XCTAssertEqual(validationError.reason, "O telefone inválido.")
        }
    }
}
