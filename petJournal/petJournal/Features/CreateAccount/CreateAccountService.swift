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
        
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.signupURL) else {
            completion(.failure(.invalidURL))
            return
        }
        
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
            default:
                completion(.failure(.internalServerError))
            }
        }.resume()
    }
}
