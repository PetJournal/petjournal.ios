import Foundation

@MainActor class CreateAccountViewModel: ObservableObject {
    @Published var states: RegisterStatus = .unknown
    @Published var user: UserModel = UserModel.newUser
    @Published var userSession: UserSession = .init()
    
    @Published var cancel: Bool = false
    @Published var isRegister: Bool = false
    @Published var isCheckBox: Bool = false
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    
    private let service: CreateAccountServiceProtocol
    
    init(service: CreateAccountServiceProtocol = CreateAccountService()) {
        self.service = service
    }
    
    func registerUser() async {
        guard completeRegister else { return }
        
        isLoading = true
        errorMessage = nil
        showAlert = false
        SessionManager.shared.statusRegister = .unknown
        
        do {
            let success = try await service.registerUser(model: user)
            isRegister = success
            cancel = true
            showAlert = true
            SessionManager.shared.statusRegister = .success
        } catch {
            isRegister = false
            cancel = true
            errorMessage = handleRegistrationError(error)
            showAlert = true
        }
        
        isLoading = false
    }
    
    private func handleRegistrationError(_ error: Error) -> String {
        if let networkError = error as? NetworkError {
            switch networkError {
            case .conflict:
                return "Email ou telefone já cadastrado. Faça login para acessar."
            default:
                return "Erro na comunicação com o servidor. Tente novamente mais tarde."
            }
        }
        return "Ocorreu um erro durante o registro. Por favor, tente novamente."
    }
}

// MARK: - Validation Extension
extension CreateAccountViewModel {
    var completeRegister: Bool {
        isCheckBox &&
        isValidName &&
        isValidEmail &&
        isValidLastname &&
        isValidPassword &&
        isValidPasswordMatch
    }
    
    var registrationStatusMessage: String {
        isRegister ? "Registro realizado, faça login para acessar." :
        errorMessage ?? "Preencha corretamente todos os campos."
    }
    
    var isValidPassword: Bool {
        ValidationsModel.shared.validateInput(user.password, of: .password(.default)) == nil
    }
    
    var isValidPasswordMatch: Bool {
        user.password == user.passwordConfirmation &&
        ValidationsModel.shared.validateInput(user.passwordConfirmation, of: .passMatch(.default)) == nil
    }
    
    var isValidName: Bool {
        ValidationsModel.shared.validateInput(user.firstName, of: .name(.default)) == nil
    }
    
    var isValidLastname: Bool {
        ValidationsModel.shared.validateInput(user.lastName, of: .lastName(.default)) == nil
    }
    
    var isValidPhone: Bool {
        ValidationsModel.shared.validateInput(user.phone, of: .phone(.default)) == nil
    }
    
    var isValidEmail: Bool {
        ValidationsModel.shared.validateInput(user.email, of: .email(.default)) == nil
    }
    
    // Error messages...
    var firstNameErrorMessage: String {
        ValidationsModel.shared.validateInput(user.firstName, of: .name(.default))?.reason ?? ""
    }
    
    var lastNameErrorMessage: String {
        ValidationsModel.shared.validateInput(user.lastName, of: .lastName(.default))?.reason ?? ""
    }
    
    var emailErrorMessage: String {
        ValidationsModel.shared.validateInput(user.email, of: .email(.default))?.reason ?? ""
    }
    
    var phoneErrorMessage: String {
        !user.phone.isEmpty ?
        ValidationsModel.shared.validateInput(user.phone, of: .phone(.default))?.reason ?? "" : ""
    }
    
    var messageErrorPassword: String {
        ValidationsModel.shared.validateInput(user.password, of: .password(.default))?.reason ?? ""
    }
    
    var messageErrorPasswordMatch: String {
        user.password != user.passwordConfirmation ?
        ValidationsModel.shared.validateInput(user.passwordConfirmation, of: .passMatch(.default))?.reason ?? "" : ""
    }
}
