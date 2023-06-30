//
//  ForgotError.swift
//  petJournal
//
//  Created by Marcylene Barreto on 19/06/23.
//

import Foundation

enum ForgotError: Error {
    case domainErr
    case none
    case invalidMail
}

extension ForgotError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .domainErr:
            return "Your domain is different from petjournal.com."
        case .none:
            return ""
        case .invalidMail:
            return "Error logging in. Please check the email is correct and try again."
        }
    }
}
