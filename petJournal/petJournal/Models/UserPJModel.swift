//
//  UserPJModel.swift
//  petJournal
//
//  Created by Daiane Goncalves on 20/04/23.
//

import Foundation

public struct UserModel: Codable, Identifiable, Equatable {
    public var id = UUID().uuidString
    var firstName: String
    var lastName: String
    var email: String
    var password: String
    var passwordConfirmation: String
    var phone: String
    var isPrivacyPolicyAccepted: Bool
    
    enum CodingKeys: String, CodingKey {
        case firstName, lastName, email, password, passwordConfirmation, phone
        case isPrivacyPolicyAccepted
    }
}

extension UserModel {
    static var newUser: UserModel {
        UserModel(firstName: "",
                  lastName: "",
                  email: "",
                  password: "",
                  passwordConfirmation: "",
                  phone: "",
                  isPrivacyPolicyAccepted: true)
    }
}

