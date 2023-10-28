//
//  SessionManager.swift
//  petJournal
//
//  Created by Marcylene Barreto on 27/05/23.
//

import SwiftUI

class SessionManager: ObservableObject {
    static let shared = SessionManager()
    
    @Published var userSession: UserSession = .init()
    @Published var statusLogin: AuthenticationStatus = .signOut
    @Published var statusRegister: RegisterStatus = .unknown
    
    private let defaults = UserDefaults.standard
    
    var isAuthenticated: Bool {
        return getToken() != nil
    }
    
    func login(withToken token: String) {
        defaults.set(token, forKey: userSession.token ?? "")
    }
    
    func getToken() -> String? {
        return defaults.string(forKey: userSession.token ?? "")
    }
    
    func logout() {
        defaults.removeObject(forKey: userSession.token ?? "")
    }
    
    func hasSession() {
        if isAuthenticated {
            statusLogin = .signIn
        }
    }
    
    // Register
    var isRegisted: Bool {
        return getRegister() != nil
    }
    
    func register(withUser user: String) {
        defaults.set(user, forKey: "register")
    }
    
    func getRegister() -> UserModel? {
        return defaults.object(forKey: "register") as? UserModel
    }
    
    func hasRegister() {
        if isRegisted {
            statusRegister = .success
        }
    }
}
