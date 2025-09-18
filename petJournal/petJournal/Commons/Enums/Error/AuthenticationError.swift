import Foundation

enum AuthenticationError: Error, LocalizedError {
    case invalidCredentials
    case invalidResponse
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Email or password is incorrect"
        case .invalidResponse:
            return "Invalid server response"
        case .unknown:
            return "An unknown error occurred"
        }
    }
}
