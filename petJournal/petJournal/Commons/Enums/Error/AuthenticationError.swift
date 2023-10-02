//
//  AuthenticationError.swift
//  petJournal
//
//  Created by Marcylene Barreto on 26/04/23.
//

import Foundation

enum AuthenticationError: Error {
    case invalidCredentials
    case failedToEncode
    case noData
}

extension AuthenticationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Invalid Credentials"
        case .failedToEncode:
            return "Failed to encode request body"
        case .noData:
            return "No Data"
        }
    }
}
