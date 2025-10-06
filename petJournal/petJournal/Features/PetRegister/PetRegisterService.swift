protocol PetRegisterServiceProtocol {
    func register(_ pet: PetModel) async throws -> PetModel
    func update(_ pet: PetModel) async throws -> PetModel
    func delete(petId: String) async throws
}

extension PetService: PetRegisterServiceProtocol {
    private func createFormData(for pet: PetModel) -> MultipartFormData {
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
        
        let formData = createFormData(for: pet)
        
        return try await NetworkManager.shared.multipartRequest(
            url: url,
            method: .put,
            formData: formData
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
}
