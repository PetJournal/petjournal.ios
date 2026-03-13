// MARK: - Protocol
protocol PetRegisterServiceProtocol {
    func register(_ pet: PetModel) async throws -> PetModel
    func update(_ pet: PetModel) async throws -> PetModel
    func delete(petId: String) async throws
    func fetchBreeds(for type: String) async throws -> [Breed]
    func fetchSizes(for type: String) async throws -> [PetSize]
}

// MARK: - Request Models
struct PetUpdateRequest: Codable {
    let specieName: String
    let petName: String
    let gender: String
    let breedName: String
    let size: String
    let castrated: Bool
    let dateOfBirth: String
}

// MARK: - Service Implementation
extension PetService: PetRegisterServiceProtocol {
    // MARK: - CRUD Operations
    func register(_ pet: PetModel) async throws -> PetModel {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.pet) else {
            throw NetworkError.invalidURL
        }
        
        let formData = createFormData(for: pet)
        
        return try await NetworkManager.shared.multipartRequest(
            url: url,
            method: .post,
            formData: formData
        )
    }
    
    func update(_ pet: PetModel) async throws -> PetModel {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.petUpdate(pet.id)) else {
            throw NetworkError.invalidURL
        }
        
        let body = createJSONBody(for: pet)
        
        return try await NetworkManager.shared.jsonRequest(
            url: url,
            method: .put,
            body: body
        )
    }
    
    func delete(petId: String) async throws {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.deletePet(petId)) else {
            throw NetworkError.invalidURL
        }
        
        let _: EmptyResponse = try await NetworkManager.shared.request(
            url: url,
            method: .delete
        )
    }
    
    // MARK: - Data Fetching
    func fetchBreeds(for type: String) async throws -> [Breed] {
        let path = type.lowercased() == "gato" ? URLManager.shared.breedsByCat : URLManager.shared.breedsByDog
        guard let url = URLManager.shared.makeURL(path: path) else {
            throw NetworkError.invalidURL
        }
        
        return try await NetworkManager.shared.jsonRequest(url: url, method: .get)
    }
    
    func fetchSizes(for type: String) async throws -> [PetSize] {
        let path = type.lowercased() == "gato" ? URLManager.shared.sizesByCat : URLManager.shared.sizesByDog
        guard let url = URLManager.shared.makeURL(path: path) else {
            throw NetworkError.invalidURL
        }
        
        return try await NetworkManager.shared.jsonRequest(url: url, method: .get)
    }
}

// MARK: - Private Helpers
private extension PetService {
    func createJSONBody(for pet: PetModel) -> PetUpdateRequest {
        return PetUpdateRequest(
            specieName: pet.specie.name,
            petName: pet.petName,
            gender: pet.gender,
            breedName: pet.breed.name,
            size: pet.size.name,
            castrated: pet.castrated,
            dateOfBirth: pet.dateOfBirth
        )
    }
    
    func createFormData(for pet: PetModel) -> MultipartFormData {
        var formData = MultipartFormData()
        
        formData.append(pet.specie.name, for: "specieName")
        formData.append(pet.petName, for: "petName")
        formData.append(pet.gender, for: "gender")
        formData.append(pet.breed.name, for: "breedName")
        formData.append(pet.size.name, for: "size")
        formData.append(pet.castrated ? "true" : "false", for: "castrated")
        formData.append(pet.dateOfBirth, for: "dateOfBirth")
        
        if let imageData = pet.image {
            formData.append(
                imageData,
                for: "image",
                fileName: "pet_image.jpg",
                mimeType: "image/jpeg"
            )
        }
        
        formData.finalize()
        return formData
    }
}
