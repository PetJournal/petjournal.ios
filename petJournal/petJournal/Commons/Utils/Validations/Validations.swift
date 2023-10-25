//
//  Validations.swift
//  petJournal
//
//  Created by Marcylene Barreto on 17/04/23.
//

import Foundation

class Validations {
    static var shared = Validations()
    
    struct ValidationError: Error {
        let reason: String
        init(_ reason: String) {
            self.reason = reason
        }
    }

    func validate(_ text: String, type: ValidationType) throws {
        guard !text.isEmpty else {
            throw ValidationError(String(format: NSLocalizedString("%@ validation-error", comment: "Localizable"), "\(type.description)"))
        }
        guard text.range(of: type.pattern, options: .regularExpression) != nil else {
            throw handleError(of: type)
        }
    }

    private func handleError(of type: ValidationType) -> ValidationError {
        switch type {
        case .email(_):
            return ValidationError("validation-invalid-email".localized)
        case .password(_):
            return ValidationError("validation-invalid-password".localized)
        case .name(_):
            return ValidationError("validation-name".localized)
        case .lastName(_):
            return ValidationError("validation-invalid-last-name".localized)
        case .phone(_):
            return ValidationError("validation-invalid-phone".localized)
        case .passMatch(_):
            return ValidationError("validation-passwords-math".localized)
        }
    }
}

extension Validations {
    enum ValidationType: CustomStringConvertible {
        case name(Pattern)
        case lastName(Pattern)
        case phone(Pattern)
        case password(Pattern)
        case email(Pattern)
        case passMatch(Pattern)
        
        enum Pattern {
            case `default`
            case custom(String)
        }
        
        var pattern: String {
            switch self {
            case .email(let pattern):
                switch pattern {
                case .default:
                    return "^[\\w-\\.]+@([\\w-]+\\.)+[\\w-]{2,4}$"
                case .custom(let string):
                    return string
                }
            case .password(let pattern):
                switch pattern {
                case .default:
                    return "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[$@$#!%*?&]).{8,}$"
                case .custom(let string):
                    return string
                }
            case .name(let pattern):
                switch pattern {
                case .default:
                    return "^[A-Za-z]{3,}.*+$"
                case .custom(let string):
                    return string
                }
            case .lastName(let pattern):
                switch pattern {
                case .default:
                    return "^[A-Za-z]{3,16}.*+$"
                case .custom(let string):
                    return string
                }
            case .phone(let pattern):
                switch pattern {
                case .default:
                    return "^[0-9]{2}.*[0-9]{5}.*[0-9]{4}$"
                case .custom(let string):
                    return string
                }
            case .passMatch(let pattern):
                switch pattern {
                case .default:
                    return "^(?=.*\\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[$@$#!%*?&]).{8,}$"
                case .custom(let string):
                    return string
                }
            }
        }
        
        var description: String {
            switch self {
            case .email(_):
                return "validation-description-email".localized
            case .password(_):
                return "validation-description-password".localized
            case .name(_):
                return "validation-description-name".localized
            case .lastName(_):
                return "validation-description-last-name".localized
            case .phone(_):
                return "validation-description-phone".localized
            case .passMatch(_):
                return "validation-description-field".localized
            }
        }
    }
}
