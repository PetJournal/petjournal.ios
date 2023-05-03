//
//  LoginService.swift
//  petJournal
//
//  Created by Marcylene Barreto on 18/04/23.
//

import Foundation

final class LoginService {
    static let shared = LoginService()
    private var user = UserModel(email: "", password: "")
    
    private init() { }
    
    func loginUser(email: String, password: String, completion: @escaping(Bool) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            if email == "test@mail.com" && password == "password" {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
}
