import Foundation

protocol PetHomeServiceProtocol {
    func fetchTags() async throws -> [TagModel]
}

class PetHomeService: PetHomeServiceProtocol {
    func fetchTags() async throws -> [TagModel] {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.tag) else {
            throw NetworkError.invalidURL
        }
        
        return try await NetworkManager.shared.jsonRequest(url: url, method: .get)
    }
}
