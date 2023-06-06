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
    case privacy = "keyGeneralPrivacy"
}

enum KeysUser: String {
    case userName = "keyUserName"
}

struct SessionState {
    var hasSession: Bool {
        set { UserDefaults.standard.set(newValue, forKey: KeysGeneral.hasSession.rawValue) }
        get { UserDefaults.standard.bool(forKey: KeysGeneral.hasSession.rawValue) }
    }
    
    var token: String? {
        set { UserDefaults.standard.set(newValue, forKey: KeysGeneral.token.rawValue) }
        get { UserDefaults.standard.string(forKey: KeysGeneral.token.rawValue) }
    }

    var userName: String? {
        set { UserDefaults.standard.set(newValue, forKey: KeysUser.userName.rawValue) }
        get { UserDefaults.standard.string(forKey: KeysUser.userName.rawValue) }
    }
    
    var checkPrivacy: String? {
        set { UserDefaults.standard.set(newValue, forKey: KeysGeneral.privacy.rawValue) }
        get { UserDefaults.standard.string(forKey: KeysGeneral.privacy.rawValue) }
    }
}
