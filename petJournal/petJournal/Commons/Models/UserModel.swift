//
//  UserModel.swift
//  petJournal
//
//  Created by Marcylene Barreto on 24/03/23.
//

import Foundation

public struct UserModel: Decodable {
    let email: String?
    let password: String?
    
    enum CodingKeys: String, CodingKey {
        case email
        case password
    }
}
