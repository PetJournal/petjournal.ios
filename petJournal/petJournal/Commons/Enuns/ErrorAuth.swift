//
//  ErrorAuth.swift
//  petJournal
//
//  Created by Marcylene Barreto on 04/04/23.
//

import Foundation
enum ErrorAuth: LocalizedError {
    case invalidInput
    case blank
    
    var errorDescription: String? {
        switch self {
        case .invalidInput: return "Usuário ou senha incorretos"
        case .blank: return ""
        }
    }
}
