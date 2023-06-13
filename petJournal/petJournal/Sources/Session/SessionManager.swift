//
//  SessionManager.swift
//  petJournal
//
//  Created by Marcylene Barreto on 27/05/23.
//

import SwiftUI

class SessionManager: ObservableObject {
    static let shared = SessionManager()
    
    @Published var singState: UserSession = .init()
        
    func updateValidation(with sessionModel: SessionModel) {
        withAnimation {
            if let model: UserModel = sessionModel.model {
                singState.firstName = model.name
                singState.lastName = model.lastName
                singState.email = model.email
                singState.phone = model.phoneNumber
            }
            singState.token = UUID().uuidString
            singState.hasSession = true
        }
    }
    
    func endSession() {
        UserDefaults.standard.removeObject(forKey: KeysGeneral.token.rawValue)
        UserDefaults.standard.removeObject(forKey: KeysUser.firstName.rawValue)
        singState.hasSession = false
    }
}
