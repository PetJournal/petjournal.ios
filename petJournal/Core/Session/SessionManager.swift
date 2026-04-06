import Foundation

class SessionManager: ObservableObject {
    static let shared = SessionManager()
    
    @Published var userSession: UserSession = .init()
    @Published var statusLogin: AuthenticationStatus = .signOut
    @Published var statusRegister: RegisterStatus = .unknown
    
    var isAuthenticated: Bool {
        return userSession.token != nil && !(userSession.token?.isEmpty ?? true)
    }
    
    func login(withToken token: String) {
        userSession.token = token
        userSession.hasSession = true
        statusLogin = .signIn
        debugTokenStatus()
    }
    
    func getToken() -> String? {
        return userSession.token
    }
    
    func logout() {
        userSession.token = nil
        userSession.hasSession = false
        userSession.firstName = nil
        userSession.lastName = nil
        userSession.email = nil
        userSession.phone = nil
        userSession.password = nil
        userSession.registerUser = nil
        
        statusLogin = .signOut
        debugTokenStatus()
    }
    
    func hasSession() -> Bool {
        return isAuthenticated
    }
    
    private func debugTokenStatus() {
        #if DEBUG
        print("Token exists: \(userSession.token != nil)")
        print("Token value: \(userSession.token ?? "nil")")
        print("Has session: \(userSession.hasSession)")
        print("Is authenticated: \(isAuthenticated)")
        #endif
    }
}
