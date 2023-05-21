//
//  SessionManager.swift
//  petJournal
//
//  Created by Marcylene Barreto on 16/05/23.
//

import SwiftUI

class SessionVM: ObservableObject {
    
    // MARK: Properties
    static let shared = SessionVM()
    
    @Published var singState: SignState = .signedOut
    
    enum KeysUser: String {
        case email = "keyUserEmail"
        case session = "userSession"
    }
    
    var userEmail: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: KeysUser.email.rawValue)
        }
        get {
            UserDefaults.standard.string(forKey: KeysUser.email.rawValue)
        }
    }
    
    var session: SignState? {
        set {
            UserDefaults.standard.set(newValue, forKey: KeysUser.session.rawValue)
        }
        get {
            UserDefaults.standard.object(forKey: KeysUser.session.rawValue) as? SignState
        }
    }
    
    func updateValidation(success: SignState, email: String) {
        withAnimation {
            userEmail = email
            session = success
            singState = success
        }
    }
}
