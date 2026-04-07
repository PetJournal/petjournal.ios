import Foundation

struct RegisterRequestBody: Codable {
    public var id = UUID().uuidString
    var firstName: String
    var lastName: String
    var email: String
    var password: String
    var passwordConfirmation: String
    var phone: String
    var isPrivacyPolicyAccepted: Bool
}
