import Foundation

struct LoginResponse: Codable {
    let accessToken: String?
}

struct LoginRequestBodyAuth: Codable {
    let email: String
    let password: String
}
