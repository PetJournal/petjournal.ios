protocol PetRegisterServiceProtocol {
    func registerPet(petToBeRegistered: PetModel) async throws -> PetModel
}

class PetRegisterService: PetRegisterServiceProtocol {
    func registerPet(petToBeRegistered: PetModel) async throws -> PetModel {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.pet) else {
            throw NetworkError.invalidURL
        }
        
        var formData = MultipartFormData()
        
        // Add fields
        formData.append(petToBeRegistered.specie.name, for: "specieName")
        formData.append(petToBeRegistered.petName, for: "petName")
        formData.append(petToBeRegistered.gender, for: "gender")
        formData.append(petToBeRegistered.breed.name, for: "breedName")
        formData.append(petToBeRegistered.size.name, for: "size")
        formData.append(petToBeRegistered.castrated ? "true" : "false", for: "castrated")
        formData.append(petToBeRegistered.dateOfBirth, for: "dateOfBirth")
        
        // Add image if exists
        if let imageData = petToBeRegistered.image {
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
