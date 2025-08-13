protocol PetListServiceProtocol {
    func fetchPets() async throws -> [PetModel]
}

class PetListService: PetListServiceProtocol {
    func fetchPets() async throws -> [PetModel] {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.pet) else {
            throw NetworkError.invalidURL
        }
        
        return try await NetworkManager.shared.jsonRequest(
            url: url,
            method: .get
        )
    }
}
