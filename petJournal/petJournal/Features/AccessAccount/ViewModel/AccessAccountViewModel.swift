import SwiftUI

@MainActor
final class AccessAccountViewModel: ObservableObject {
    @Published var user: UserModel = UserModel.newUser
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var errorMessage: String = ""
    
    private let service: AccessAccountServiceProtocol
    private let sessionManager: SessionManager
    
    init(
        service: AccessAccountServiceProtocol = AccessAccountService(),
        sessionManager: SessionManager = .shared
    ) {
        self.service = service
        self.sessionManager = sessionManager
    }
    
    func authUser() async {
        guard isValidEmail && isValidPassword else { return }
        
        isLoading = true
        showAlert = false
        errorMessage = ""
        
        do {
            let token = try await service.authenticationEmail(
                email: user.email,
                password: user.password
            )
            
            sessionManager.login(withToken: token)
            
        } catch let error as AuthenticationError {
            errorMessage = error.localizedDescription
            showAlert = true
            sessionManager.logout()
        } catch {
            errorMessage = "Ocorreu um erro inesperado"
            showAlert = true
            sessionManager.logout()
        }
        
        isLoading = false
    }

    func logout() {
        sessionManager.logout()
    }
}

// MARK: - Validation
extension AccessAccountViewModel {
    var completeLogin: Bool {
        isValidEmail && isValidPassword
    }
    
    var isValidEmail: Bool {
        ValidationsModel.shared.validateInput(user.email, of: .email(.default)) == nil
    }
    
    var isValidPassword: Bool {
        ValidationsModel.shared.validateInput(user.password, of: .password(.default)) == nil
    }
    
    var emailErrorMessage: String {
        ValidationsModel.shared.validateInput(user.email, of: .email(.default))?.reason ?? ""
    }
    
    var passwordErrorMessage: String {
        ValidationsModel.shared.validateInput(user.password, of: .password(.default))?.reason ?? ""
    }
}
