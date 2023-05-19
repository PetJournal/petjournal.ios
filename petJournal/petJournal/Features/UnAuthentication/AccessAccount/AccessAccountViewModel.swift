//
//  AccessAccountViewModel.swift
//  petJournal
//
//  Created by Marcylene Barreto on 24/03/23.
//

import Foundation

final class AccessAccountViewModel {
    var error: ObservableObject<String?> = ObservableObject(nil)
    
    func authUser(_ email: String, pass: String) {
        LoginService.shared.loginUser(email: email, password: pass) { [weak self] success in
            self?.error.value = success ? nil : "Error credentials!"
        }
    }
}
