import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case noData
    case decodingFailed
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case notAcceptable
    case conflict
    case serverError
    case unknown(statusCode: Int)
    
    var localizedDescription: String {
        switch self {
        case .invalidURL: return "Invalid URL"
        case .invalidResponse: return "Invalid response from server"
        case .noData: return "No data received"
        case .decodingFailed: return "Failed to decode response"
        case .badRequest: return "Bad request"
        case .unauthorized: return "Unauthorized access"
        case .forbidden: return "Forbidden access"
        case .notFound: return "Resource not found"
        case .notAcceptable: return "Request not acceptable"
        case .conflict: return "Conflict occurred"
        case .serverError: return "Server error"
        case .unknown(let code): return "Unknown error (code: \(code))"
        }
    }
}
