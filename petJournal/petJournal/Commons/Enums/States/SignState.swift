//
//  SignState.swift
//  petJournal
//
//  Created by Marcylene Barreto on 26/04/23.
//

import Foundation

enum SignState {
    case signedIn
    case signedOut
    case unknown
}

enum ErrorState: Error {
    case domainErr
    case none
    case errorValues
}

extension ErrorState: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .domainErr:
            return "Your domain is different from petjournal.com."
        case .none:
            return ""
        case .errorValues:
            return "Error logging in. Please check the email is correct and try again."
        }
    }
}
