//
//  ReceiveInputViewModel.swift
//  petJournal
//
//  Created by Marcylene Barreto on 14/06/23.
//

import Foundation

enum ForgotState {
    case forgotCheck
    case unknown
}

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

class ForgotPasswordViewModel: ObservableObject {
    @Published var error: ForgotError = .none
    @Published var forgotState: ForgotState = .unknown
    @Published var user: UserModel = UserModel.newUser
    @Published var cancel: Bool = false
    
    var service: ForgotPasswordServiceProtocol!
    init(service: ForgotPasswordServiceProtocol) {
        self.service = service
    }
    
    func reAuthentication() {
        if isCorrectEmail {
            service.forgotPassword(credential: user.email) { result in
                switch result {
                case .success:
                    self.forgotState = .forgotCheck
                    self.error = .none
                case .failure(_):
                    ""
                }
            }
        }
    }
}

// MARK: - Extension
extension ForgotPasswordViewModel {
    var isCorrectEmail: Bool {
        if !Validations.shared.validEmail(user.email) {
            return false
        }
        return true
    }
}
