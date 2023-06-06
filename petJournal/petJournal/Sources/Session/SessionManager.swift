//
//  SessionManager.swift
//  petJournal
//
//  Created by Marcylene Barreto on 27/05/23.
//

import SwiftUI

class SessionManager: ObservableObject {
    static let shared = SessionManager()
    
    @Published var singState: SessionState = .init()
        
    func updateValidation(with model: SessionModel) {
        withAnimation {
            if let userName: String = model.userName {
                singState.userName = userName
            }
            singState.token = UUID().uuidString
            singState.hasSession = true
        }
    }
    
    func endSession() {
        UserDefaults.standard.removeObject(forKey: KeysGeneral.token.rawValue)
        UserDefaults.standard.removeObject(forKey: KeysUser.userName.rawValue)
        singState.hasSession = false
    }
}
