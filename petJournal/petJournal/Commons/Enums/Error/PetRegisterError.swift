import Foundation

enum PetRegisterError: Int, Error {
    case success = 201
    case invalidRequest = 400
    case notAccepted = 406
    case internalServerError = 500
    case invalidURL
    case invalidResponse
    
    var localizedDescription: String {
        switch self {
        case .success:
            return "Success"
        case .invalidRequest:
            return "Invalid Request"
        case .notAccepted:
            return "Not Accepted Request"
        case .internalServerError:
            return "Internal Server Error"
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid Response"
        }
    }
}
