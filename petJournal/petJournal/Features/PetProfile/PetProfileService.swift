import Foundation

protocol PetProfileServiceProtocol {
    func fetchTasks(for petId: String) async throws -> [TaskResponse]
}

class PetProfileService: PetProfileServiceProtocol {
    func fetchTasks(for petId: String) async throws -> [TaskResponse] {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.petTasks(petId)) else {
            throw NetworkError.invalidURL
        }
        
        return try await NetworkManager.shared.jsonRequest(url: url, method: .get)
    }
}
