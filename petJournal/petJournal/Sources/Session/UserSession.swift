//
//  UserSession.swift
//  petJournal
//
//  Created by Marcylene Barreto on 27/05/23.
//

import Foundation

enum KeysGeneral: String {
    case token = "keyGeneralToken"
    case hasSession = "keyGeneralHasSession"
    case registerUser = "keyRegisterUser"
}

enum KeysUser: String {
    case id = "keyID"
    case firstName = "keyFirstName"
    case lastName = "keyLastName"
    case email = "keyEmail"
    case phone = "keyPhone"
    case password = "keyPassword"
}

struct UserSession: Codable {
    var hasSession: Bool {
        get { UserDefaults.standard.bool(forKey: KeysGeneral.hasSession.rawValue) }
        set { UserDefaults.standard.set(newValue, forKey: KeysGeneral.hasSession.rawValue) }
    }

    var token: String? {
        get {
            return KeychainHelper.getValue(for: KeysGeneral.token.rawValue)
        }
        set {
            KeychainHelper.setValue(value: KeysGeneral.token.rawValue, for: newValue ?? "")
        }
    }

    var registerUser: String? {
        set { UserDefaults.standard.set(newValue, forKey: KeysGeneral.registerUser.rawValue) }
        get { UserDefaults.standard.string(forKey: KeysGeneral.registerUser.rawValue) }
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

    // TODO: mudar de UserDefault para Keychain na Password
    var password: String? {
        set {
            UserDefaults.standard.set(newValue, forKey: KeysUser.password.rawValue)
            KeychainHelper.setValue(value: KeysUser.password.rawValue, for: newValue ?? "")
        }
        get {
            return KeychainHelper.getValue(for: KeysUser.password.rawValue)
        }
    }
}
