import Foundation

protocol AccessAccountServiceProtocol {
    func authenticationEmail(email: String, password: String) async throws -> String
}

final class AccessAccountService: AccessAccountServiceProtocol {
    func authenticationEmail(email: String, password: String) async throws -> String {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.loginURL) else {
            throw NetworkError.invalidURL
        }
        
        let body = LoginRequestBodyAuth(email: email, password: password)
        
        do {
            let response: LoginResponse = try await NetworkManager.shared.jsonRequest(
                url: url,
                method: .post,
                body: body
            )
            
            guard let token = response.accessToken else {
                throw AuthenticationError.invalidCredentials
            }
            
            return token
        } catch let error as NetworkError {
            // Map network errors to authentication errors
            switch error {
            case .unauthorized:
                throw AuthenticationError.invalidCredentials
            case .noData, .decodingFailed:
                throw AuthenticationError.invalidResponse
            default:
                throw AuthenticationError.unknown
            }
        } catch {
            throw AuthenticationError.unknown
        }
    }
}
