import SwiftUI

class PetRegisterViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var isLoading = false
    @Published var showAlert = false
    @Published var alertMessage = ""
    @Published var isSuccessAlert = false
    @Published var errorMessage: String?
    
    @Published var pet: PetModel?
    @Published var breeds: [String] = []
    @Published var sizes: [String] = []
    
    @Published var name = ""
    @Published var breed: String?
    @Published var size: String?
    @Published var birthDate = ""
    @Published var type: String?
    @Published var gender = ""
    @Published var isCastrated = ""
    @Published var image = UIImage()
    
    // MARK: - Private Properties
    private let service: PetRegisterServiceProtocol
    private let cache = PetDataCache()
    
    var animalTypes: [String] { ["Cachorro", "Gato"] }
    
    var isValid: Bool {
        let fields = [name, gender, type ?? "", breed ?? "", size ?? "", birthDate, isCastrated]
        let isValid = fields.allSatisfy { !$0.isEmpty }
        
        if !isValid {
            errorMessage = "Por favor, preencha todos os campos obrigatórios."
        }
        return isValid
    }
    
    // MARK: - Initialization
    init(pet: PetModel? = nil, service: PetRegisterServiceProtocol = PetService()) {
        self.service = service
        self.pet = pet
        
        if let pet = pet {
            populateFields(with: pet)
            loadDataForType(pet.specie.name)
        } else {
            type = "Cachorro"
            loadDataForType("Cachorro")
        }
        
        Task { await loadInitialData() }
    }
}

// MARK: - Public Methods
extension PetRegisterViewModel {
    func save() async {
        guard isValid else { return }
        
        await setLoading(true)
        
        do {
            let petModel = buildPetModel()
            let savedPet = pet != nil ? try await service.update(petModel) : try await service.register(petModel)
            await handleSuccess(savedPet)
        } catch {
            await handleError(error)
        }
    }
    
    func deletePet() async {
        guard let petId = pet?.id else { return }
        
        await setLoading(true)
        
        do {
            try await service.delete(petId: petId)
            await handleDeleteSuccess()
        } catch {
            await handleError(error)
        }
    }
    
    func showDeleteConfirmation() {
        alertMessage = "Você realmente quer excluir o pet?"
        isSuccessAlert = false
        showAlert = true
    }
    
    func dismissAlert() {
        showAlert = false
    }
    
    func clear() {
        pet = nil
        name = ""
        breed = nil
        size = nil
        birthDate = ""
        type = nil
        gender = ""
        isCastrated = ""
    }
    
    func loadDataForType(_ animalType: String) {
        breeds = cache.loadBreeds(for: animalType)
        sizes = cache.loadSizes(for: animalType)
    }
}

// MARK: - Alert Properties
extension PetRegisterViewModel {
    var alertImage: Image {
        isSuccessAlert ? Image(.imgDogAndCat) : Image(.imgCryingDog)
    }
    
    var alertButtonTitle: String {
        if isSuccessAlert {
            return "Veja seus Pets"
        } else if alertMessage.contains("excluir") {
            return "Cancelar"
        } else {
            return "Tente novamente mais tarde"
        }
    }
    
    var alertSecondaryButtonTitle: String? {
        alertMessage.contains("excluir") ? "Deletar" : nil
    }
}

// MARK: - Private Methods
private extension PetRegisterViewModel {
    func populateFields(with pet: PetModel) {
        name = pet.petName
        breed = pet.breed.name
        size = pet.size.name
        birthDate = pet.dateOfBirth.toBrazilianDateFormat()
        type = pet.specie.name
        gender = pet.gender
        isCastrated = pet.castrated ? "Sim" : "Não"
    }
    
    func loadInitialData() async {
        do {
            async let dogBreeds = service.fetchBreeds(for: "Cachorro")
            async let catBreeds = service.fetchBreeds(for: "Gato")
            async let dogSizes = service.fetchSizes(for: "Cachorro")
            async let catSizes = service.fetchSizes(for: "Gato")
            
            let (dogBreedsResult, catBreedsResult, dogSizesResult, catSizesResult) = try await (dogBreeds, catBreeds, dogSizes, catSizes)
            
            cache.saveBreeds(dogBreedsResult.map { $0.name }, for: "Cachorro")
            cache.saveBreeds(catBreedsResult.map { $0.name }, for: "Gato")
            cache.saveSizes(dogSizesResult.map { $0.name }, for: "Cachorro")
            cache.saveSizes(catSizesResult.map { $0.name }, for: "Gato")
            
            await MainActor.run {
                if let currentType = self.type {
                    self.loadDataForType(currentType)
                }
            }
        } catch {
            // Silently fail, use cached data
        }
    }
    
    func buildPetModel() -> PetModel {
        let imageData = image.jpegData(compressionQuality: 0.8)
        
        return PetModel(
            id: pet?.id ?? UUID().uuidString,
            guardian: pet?.guardian,
            specie: Species(id: UUID().uuidString, name: type ?? ""),
            specieAlias: nil,
            petName: name,
            gender: gender,
            breed: Breed(id: UUID().uuidString, name: breed ?? ""),
            breedAlias: nil,
            size: PetSize(id: UUID().uuidString, name: size ?? ""),
            castrated: isCastrated.lowercased() == "sim",
            dateOfBirth: birthDate.toAPIDateFormat() ?? birthDate,
            image: imageData
        )
    }
    
    @MainActor
    func setLoading(_ loading: Bool) {
        isLoading = loading
        if loading { errorMessage = nil }
    }
    
    @MainActor
    func handleSuccess(_ savedPet: PetModel) {
        pet = savedPet
        isLoading = false
        alertMessage = "Pet cadastrado com sucesso!"
        isSuccessAlert = true
        showAlert = true
    }
    
    @MainActor
    func handleError(_ error: Error) {
        errorMessage = error.localizedDescription
        isLoading = false
        alertMessage = "Erro ao cadastrar pet"
        isSuccessAlert = false
        showAlert = true
    }
    
    @MainActor
    func handleDeleteSuccess() {
        isLoading = false
        alertMessage = "Pet excluído com sucesso!"
        isSuccessAlert = true
        showAlert = true
    }
}
