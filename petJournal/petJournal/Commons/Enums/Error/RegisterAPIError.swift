import Foundation

enum RegisterAPIError: Int, Error {
    case success = 201
    case invalidRequest = 400
    case conflictRequest = 409
    case internalServerError = 500
    case invalidURL
    case invalidResponse
    
    var localizedDescription: String {
        switch self {
        case .success:
            return "Success"
        case .invalidRequest:
            return "Invalid Request"
        case .conflictRequest:
            return "Conflict Request"
        case .internalServerError:
            return "Internal Server Error"
        case .invalidURL:
            return "Invalid URL"
        case .invalidResponse:
            return "Invalid Response"
        }
    }
}
