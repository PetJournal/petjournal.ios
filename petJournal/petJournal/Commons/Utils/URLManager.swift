//
//  URLManager.swift
//  petJournal
//
//  Created by Marcylene Barreto on 29/09/23.
//

import Foundation

class URLManager {
    static let shared = URLManager()
    
    private init() {}
    
    let baseURL = "https://petjournal-api-pm3z.onrender.com/api"
    
    let loginURL = "/login"
    let signupURL = "/signup"
    let guardianChangePassword = "/guardian/change-password"
    let forgetPassword = "/forget-password"
    let waitingCode = "/waiting-code"
    //FIXME: - Check paths before testing
    let petRegister = "/pet-register"
    let petListing = "/pets"
    
    func makeURL(path: String) -> URL? {
        guard let fullURL = URL(string: baseURL + path) else {
            return nil
        }
        return fullURL
    }
}
