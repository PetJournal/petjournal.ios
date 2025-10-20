protocol PetRegisterServiceProtocol {
    func register(_ pet: PetModel) async throws -> PetModel
}

extension PetService: PetRegisterServiceProtocol {
    func register(_ pet: PetModel) async throws -> PetModel {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.pet) else {
            throw NetworkError.invalidURL
        }
        
        var formData = MultipartFormData()
        
        // Add fields
        formData.append(pet.specie.name, for: "specieName")
        formData.append(pet.petName, for: "petName")
        formData.append(pet.gender, for: "gender")
        formData.append(pet.breed.name, for: "breedName")
        formData.append(pet.size.name, for: "size")
        formData.append(pet.castrated ? "true" : "false", for: "castrated")
        formData.append(pet.dateOfBirth, for: "dateOfBirth")
        
        // Add image if exists
        if let imageData = pet.image {
            formData.append(
                imageData,
                for: "image",
                fileName: "pet_image.jpg",
                mimeType: "image/jpeg"
            )
        }
        
        formData.finalize()
        
        return try await NetworkManager.shared.multipartRequest(
            url: url,
            method: .post,
            formData: formData
        )
    }
}
