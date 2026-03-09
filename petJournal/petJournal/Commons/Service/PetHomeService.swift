import Foundation

protocol PetHomeServiceProtocol {
    func fetchTags() async throws -> [TagModel]
    func fetchGuardianName() async throws -> PetGuardian
}

class PetHomeService: PetHomeServiceProtocol {
    func fetchTags() async throws -> [TagModel] {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.tag) else {
            throw NetworkError.invalidURL
        }
        
        return try await NetworkManager.shared.jsonRequest(url: url, method: .get)
    }
    
    func fetchGuardianName() async throws -> PetGuardian {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.guardianName) else {
            throw NetworkError.invalidURL
        }
        
        return try await NetworkManager.shared.jsonRequest(url: url, method: .get)
    }
}
