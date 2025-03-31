import Foundation

enum PetListingError: Int, Error {
    case success = 200
    case invalidRequest = 400
    case unauthorizedGuardian = 401
    case internalServerError = 500
    case invalidURL
    case invalidResponse
    
    var localizedDescription: String {
        switch self {
        case .success:
            return "Success"
        case .invalidRequest:
            return "Invalid Request"
        case .unauthorizedGuardian:
            return "Invalid or expired token"
        case .internalServerError:
            return "Internal Server Error"
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid Response"
        }
    }
}
