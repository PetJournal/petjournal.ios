//
//  CreateAccountService.swift
//  petJournal
//
//  Created by Daiane Goncalves on 19/05/23.
//

import Foundation

protocol CreateAccountServiceProtocol {
    func registerUser(userModel: UserModel, completion: @escaping (Result<UserModel, ErrorRegisterApp>) -> Void)
}

class CreateAccountService: CreateAccountServiceProtocol {
    func registerUser(userModel: UserModel, completion: @escaping (Result<UserModel, ErrorRegisterApp>) -> Void) {
        let url = URLManager.shared.makeURL(path: URLManager.shared.signupURL)!
        
        let body = RegisterRequestBody(firstName: userModel.firstName,
                                       lastName: userModel.lastName,
                                       email: userModel.email,
                                       password: userModel.password,
                                       passwordConfirmation: userModel.passwordConfirmation,
                                       phone: userModel.phone,
                                       isPrivacyPolicyAccepted: userModel.isPrivacyPolicyAccepted)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        do {
            request.httpBody = try JSONEncoder().encode(body)
        } catch {
            completion(.failure(.error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, error == nil else {
                completion(.failure(.errorRegister))
                return
            }
            
            do {
                let registerResponse = try JSONDecoder().decode(RegisterResponse.self, from: data)
                guard let token = registerResponse.user else {
                    completion(.failure(.error))
                    return
                }
                completion(.success(token))
            } catch {
                completion(.failure(.error))
            }
        }.resume()
    }
}
