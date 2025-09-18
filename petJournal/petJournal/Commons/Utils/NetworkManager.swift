import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
        case delete = "DELETE"
        case patch = "PATCH"
    }
    
    enum ContentType {
        case json
        case multipartForm(boundary: String)
        
        var headerValue: String {
            switch self {
            case .json: return "application/json"
            case .multipartForm(let boundary): return "multipart/form-data; boundary=\(boundary)"
            }
        }
    }
    
    func request<T: Decodable>(
        url: URL,
        method: HTTPMethod,
        contentType: ContentType = .json,
        body: Data? = nil,
        headers: [String: String]? = nil
    ) async throws -> T {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.addValue(contentType.headerValue, forHTTPHeaderField: "Content-Type")
        
        if let token = SessionManager.shared.getToken(), !token.isEmpty {
            request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        } else {
            print("Warning: No token available for request")
        }
        
        headers?.forEach { request.addValue($1, forHTTPHeaderField: $0) }
        request.httpBody = body
        
        let (data, response) = try await URLSession.shared.debugRequest(request)
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw handleError(statusCode: httpResponse.statusCode, data: data)
        }
        
        do {
            return try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw NetworkError.decodingFailed
        }
    }
    
    // MARK: - Convenience Methods
    func jsonRequest<T: Decodable>(
        url: URL,
        method: HTTPMethod,
        body: Encodable? = nil
    ) async throws -> T {
        let bodyData = try body.map { try JSONEncoder().encode($0) }
        return try await request(url: url, method: method, contentType: .json, body: bodyData)
    }
    
    func multipartRequest<T: Decodable>(
        url: URL,
        method: HTTPMethod,
        formData: MultipartFormData
    ) async throws -> T {
        return try await request(
            url: url,
            method: method,
            contentType: .multipartForm(boundary: formData.boundary),
            body: formData.data
        )
    }
    
    private func handleError(statusCode: Int, data: Data) -> Error {
        // Custom error decoding can be added here
        switch statusCode {
        case 400: return NetworkError.badRequest
        case 401: return NetworkError.unauthorized
        case 403: return NetworkError.forbidden
        case 404: return NetworkError.notFound
        case 406: return NetworkError.notAcceptable
        case 409: return NetworkError.conflict
        case 500...599: return NetworkError.serverError
        default: return NetworkError.unknown(statusCode: statusCode)
        }
    }
}

struct MultipartFormData {
    let boundary: String
    var data: Data
    
    init() {
        self.boundary = UUID().uuidString
        self.data = Data()
    }
    
    mutating func append(_ value: String, for name: String) {
        data.append("--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(name)\"\r\n\r\n".data(using: .utf8)!)
        data.append("\(value)\r\n".data(using: .utf8)!)
    }
    
    mutating func append(_ fileData: Data, for name: String, fileName: String, mimeType: String) {
        data.append("--\(boundary)\r\n".data(using: .utf8)!)
        data.append("Content-Disposition: form-data; name=\"\(name)\"; filename=\"\(fileName)\"\r\n".data(using: .utf8)!)
        data.append("Content-Type: \(mimeType)\r\n\r\n".data(using: .utf8)!)
        data.append(fileData)
        data.append("\r\n".data(using: .utf8)!)
    }
    
    mutating func finalize() {
        data.append("--\(boundary)--\r\n".data(using: .utf8)!)
    }
}
