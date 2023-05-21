//
//  UserModel.swift
//  petJournal
//
//  Created by Marcylene Barreto on 24/03/23.
//

import Foundation

public struct UserModel: Decodable, Identifiable {
    public var id = UUID().uuidString
    var email: String
    var password: String
    var passwordMatch: String
    
    enum CodingKeys: String, CodingKey {
        case email, password, passwordMatch
    }
}

extension UserModel {
    static var newUser: UserModel {
        UserModel(email: "",
                  password: "",
                  passwordMatch: "")
    }
}
