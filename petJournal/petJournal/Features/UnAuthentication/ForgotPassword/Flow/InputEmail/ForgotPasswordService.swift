//
//  ForgotPasswordService.swift
//  petJournal
//
//  Created by Marcylene Barreto on 14/06/23.
//

import Foundation

protocol ForgotPasswordServiceProtocol {
    func forgotPassword(email: String, completion: @escaping (Result<String, ForgotError>) -> Void)
}

class ForgotPasswordService: ForgotPasswordServiceProtocol {
    func forgotPassword(email: String, completion: @escaping (Result<String, ForgotError>) -> Void) {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.forgetPassword) else {
            completion(.failure(.invalidUrl))
            return
        }
        
        let body = RecoveryPasswordRequestBodyForgetPassword(email: email)
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        do {
            let jsonEnconder = try JSONEncoder().encode(body)
            request.httpBody = jsonEnconder
        } catch {
            completion(.failure(.invalidUrl))
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in 
            guard let data = data, error == nil else {
                completion(.failure(.noData))
                return
            }
            do {
                debugPrint(data)
                let returnData = try JSONDecoder().decode(ForgetPasswordResponse.self, from: data)
                completion(.success(returnData.message))
                
            } catch {
                completion(.failure(.domainErr))
            }
        }.resume()
    }
}
