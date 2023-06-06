//
//  UserPJModel.swift
//  petJournal
//
//  Created by Daiane Goncalves on 20/04/23.
//

import Foundation

public struct UserModel: Codable, Identifiable, Equatable {
    public var id = UUID().uuidString
    var name: String
    var lastName: String
    var email: String
    var phoneNumber: String
    var password: String
    var passwordMatch: String
//    var polityAndPrivacy: Bool
    
    enum CodingKeys: String, CodingKey {
        case name, lastName, email, phoneNumber, password, passwordMatch
//        case polityAndPrivacy
    }
}

extension UserModel {
    static var newUser: UserModel {
        UserModel(name: "",
                  lastName: "",
                  email: "",
                  phoneNumber: "",
                  password: "",
                  passwordMatch: "")
    }
}

