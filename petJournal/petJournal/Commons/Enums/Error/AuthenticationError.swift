//
//  AuthenticationError.swift
//  petJournal
//
//  Created by Marcylene Barreto on 26/04/23.
//

import Foundation

enum AuthenticationError: Error {
    case invalidCredentials
    case custom(errorMessage: String)
}
