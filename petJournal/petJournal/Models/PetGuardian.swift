import Foundation

struct PetGuardian: Identifiable, Hashable, Codable {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let phone: String
    let image: Data?
}