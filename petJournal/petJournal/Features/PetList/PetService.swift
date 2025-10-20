protocol PetServiceProtocol {
    func fetch() async throws -> [PetModel]
}

class PetService: PetServiceProtocol {
    func fetch() async throws -> [PetModel] {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.pet) else {
            throw NetworkError.invalidURL
        }
        
        return try await NetworkManager.shared.jsonRequest(url: url, method: .get)
    }
}
