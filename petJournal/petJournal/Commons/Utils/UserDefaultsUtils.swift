//
//  UserDefaultsUtils.swift
//  petJournal
//
//  Created by Marcylene Barreto on 01/06/23.
//

import Foundation

class UserDefaultsUtils {
    static func save(value: Any, key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    static func get(key: String) -> Any? {
        let value = UserDefaults.standard.object(forKey: key)
        return value
    }
    
    static func deleteData(key: String) {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
