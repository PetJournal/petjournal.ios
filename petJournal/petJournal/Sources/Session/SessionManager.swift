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
        
    func updateValidation(with sessionModel: SessionModel) {
        withAnimation {
            if let model: UserModel = sessionModel.model {
                userSession.firstName = model.name
                userSession.lastName = model.lastName
                userSession.email = model.email
                userSession.phone = model.phoneNumber
                userSession.password = model.password
            }
            userSession.token = UUID().uuidString
            userSession.hasSession = true
        }
    }
    
    func endSession() {
        UserDefaults.standard.removeObject(forKey: KeysGeneral.token.rawValue)
        UserDefaults.standard.removeObject(forKey: KeysUser.firstName.rawValue)
        userSession.hasSession = false
    }
}
