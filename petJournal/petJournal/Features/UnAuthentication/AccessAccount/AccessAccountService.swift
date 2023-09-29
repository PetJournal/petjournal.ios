//
//  LoginService.swift
//  petJournal
//
//  Created by Marcylene Barreto on 18/04/23.
//

import Foundation

protocol AccessAccountServiceProtocol {
    func authenticationEmail(email: String, password: String, completion: @escaping(Result<String, AuthenticationError>) -> Void)
}

final class AccessAccountService: AccessAccountServiceProtocol {
    func authenticationEmail(email: String, password: String, completion: @escaping(Result<String, AuthenticationError>) -> Void) {
        let url = URLManager.shared.makeURL(path: URLManager.shared.loginURL)!
        
        let body = LoginRequestBodyAuth(email: email, password: password)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            completion(.failure(.custom(errorMessage: "Failed to encode request body")))
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.custom(errorMessage: "No data")))
                return
            }
            
            do {
                let loginResponse = try JSONDecoder().decode(LoginResponse.self, from: data)
                guard let token = loginResponse.accessToken else {
                    completion(.failure(.invalidCredentials))
                    return
                }
                completion(.success(token))
            } catch {
                completion(.failure(.invalidCredentials))
            }
        }.resume()
    }
}
