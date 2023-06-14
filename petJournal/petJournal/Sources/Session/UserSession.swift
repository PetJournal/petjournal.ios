//
//  SessionState.swift
//  petJournal
//
//  Created by Marcylene Barreto on 27/05/23.
//

import Foundation

enum KeysGeneral: String {
    case token = "keyGeneralToken"
    case hasSession = "keyGeneralHasSession"
}

enum KeysUser: String {
    case firstName = "keyFirstName"
    case lastName = "keyLastName"
    case email = "keyEmail"
    case phone = "keyPhone"
}

struct UserSession {
    var hasSession: Bool {
        set { UserDefaults.standard.set(newValue, forKey: KeysGeneral.hasSession.rawValue) }
        get { UserDefaults.standard.bool(forKey: KeysGeneral.hasSession.rawValue) }
    }
    
    var token: String? {
        set { UserDefaults.standard.set(newValue, forKey: KeysGeneral.token.rawValue) }
        get { UserDefaults.standard.string(forKey: KeysGeneral.token.rawValue) }
    }

    var firstName: String? {
        set { UserDefaults.standard.set(newValue, forKey: KeysUser.firstName.rawValue) }
        get { UserDefaults.standard.string(forKey: KeysUser.firstName.rawValue) }
    }
    
    var lastName: String? {
        set { UserDefaults.standard.set(newValue, forKey: KeysUser.lastName.rawValue) }
        get { UserDefaults.standard.string(forKey: KeysUser.lastName.rawValue) }
    }
    
    var email: String? {
        set { UserDefaults.standard.set(newValue, forKey: KeysUser.email.rawValue) }
        get { UserDefaults.standard.string(forKey: KeysUser.email.rawValue) }
    }
    
    var phone: String? {
        set { UserDefaults.standard.set(newValue, forKey: KeysUser.phone.rawValue) }
        get { UserDefaults.standard.string(forKey: KeysUser.phone.rawValue) }
    }
}
