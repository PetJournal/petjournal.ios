//
//  CreateAccountService.swift
//  petJournal
//
//  Created by Daiane Goncalves on 19/05/23.
//

import Foundation

protocol CreateAccountServiceProtocol {
    func registerUser(model: UserModel,
                      completion: @escaping(Result<Bool, RegisterAPIError>) -> Void)
}

class CreateAccountService: CreateAccountServiceProtocol {
    func registerUser(model: UserModel,
                      completion: @escaping(Result<Bool, RegisterAPIError>) -> Void) {
        
        let url = URLManager.shared.makeURL(path: URLManager.shared.signupURL)!
        let body = RegisterRequestBody(firstName: model.firstName,
                                       lastName: model.lastName,
                                       email: model.email,
                                       password: model.password,
                                       passwordConfirmation: model.passwordConfirmation,
                                       phone: model.phone,
                                       isPrivacyPolicyAccepted: model.isPrivacyPolicyAccepted)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            switch httpResponse.statusCode {
            case RegisterAPIError.success.rawValue:
                completion(.success(true))
            case RegisterAPIError.invalidRequest.rawValue:
                completion(.failure(.invalidRequest))
            case RegisterAPIError.conflictRequest.rawValue:
                completion(.failure(.conflictRequest))
            case RegisterAPIError.internalServerError.rawValue:
                completion(.failure(.internalServerError))
            default:
                completion(.failure(.httpError))
            }
        }.resume()
    }
}

enum RegisterAPIError: Int, Error {
    case success = 201
    case invalidRequest = 400
    case conflictRequest = 409
    case internalServerError = 500
    case invalidURL
    case invalidResponse
    case httpError
    
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
        case .httpError:
            return "HTTP Error"
        }
    }
}
