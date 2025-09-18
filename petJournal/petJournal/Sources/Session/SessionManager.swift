import Foundation

class SessionManager: ObservableObject {
    static let shared = SessionManager()
    
    @Published var userSession: UserSession = .init()
    @Published var statusLogin: AuthenticationStatus = .signOut
    @Published var statusRegister: RegisterStatus = .unknown
    
    var isAuthenticated: Bool {
        return getToken() != nil
    }
    
    func login(withToken token: String) {
        userSession.token = token
        userSession.hasSession = true
    }
    
    func getToken() -> String? {
        return userSession.token
    }
    
    func logout() {
        userSession.token = nil
        userSession.hasSession = false
    }
    
    func hasSession() {
        if isAuthenticated {
            statusLogin = .signIn
        }
    }
}
