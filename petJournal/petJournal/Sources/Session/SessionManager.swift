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
}
