import SwiftUI

class PetRegisterViewModel: ObservableObject {
    @Published var isLoading = false
    @Published var isSuccess = false
    @Published var errorMessage: String?
    @Published var pet: PetModel?
    
    @Published var name = ""
    @Published var breed: String?
    @Published var size: String?
    @Published var birthDate = ""
    @Published var type: String?
    @Published var gender = ""
    @Published var isCastrated = ""
    @Published var image = UIImage()

    private let service: PetRegisterServiceProtocol
    static let shared = PetRegisterViewModel()
    
    init(service: PetRegisterServiceProtocol = PetService()) {
        self.service = service
    }
}

// MARK: - Public Methods
extension PetRegisterViewModel {
    func save() async {
        guard isValid else { return }
        
        await setLoading(true)
        
        do {
            let petModel = buildPetModel()
            let savedPet = try await service.register(petModel)
            await handleSuccess(savedPet)
        } catch {
            await handleError(error)
        }
    }
    
    func loadSampleImage() async {
        do {
            guard let fetchedImage = try await AsyncImageService.asyncImage(from: Constants.sampleImageURL) else { return }
            await updateImage(fetchedImage)
        } catch {
            debugPrint("Failed to load sample image")
        }
    }
    
    var breeds: [String] { PetData.breeds }
    var sizes: [String] { PetData.sizes }
    var animalTypes: [String] { PetData.types }
    
    func populate(with pet: PetModel) {
        self.pet = pet
        name = pet.petName
        breed = pet.breed.name
        size = pet.size.name
        birthDate = pet.dateOfBirth
        type = pet.specie.name
        gender = pet.gender
        isCastrated = pet.castrated ? "Sim" : "Não"
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
}

// MARK: - Private Methods
private extension PetRegisterViewModel {
    func buildPetModel() -> PetModel {
        let imageData = image.jpegData(compressionQuality: 0.8)
        
        return PetModel(
            id: UUID().uuidString,
            guardianId: nil,
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
        isSuccess = true
        pet = savedPet
        isLoading = false
    }
    
    @MainActor
    func handleError(_ error: Error) {
        errorMessage = error.localizedDescription
        isLoading = false
    }
    
    @MainActor
    func updateImage(_ newImage: UIImage?) {
        if let newImage = newImage, var currentPet = pet {
            currentPet.petImage = Image(uiImage: newImage)
            pet = currentPet
        }
    }
}

// MARK: - Validation
extension PetRegisterViewModel {
    var isValid: Bool {
        let fields = [name, gender, type ?? "", breed ?? "", size ?? "", birthDate, isCastrated]
        let isValid = fields.allSatisfy { !$0.isEmpty }
        
        if !isValid {
            errorMessage = "Por favor, preencha todos os campos obrigatórios."
        }
        return isValid
    }
}

// MARK: - Constants
// MARK: - Static Data
private enum PetData {
    static let breeds = ["Labrador Retriever", "Bulldog Francês", "Golden Retriever", "Poodle", "Shih Tzu", "Siamês", "Persa", "Maine Coon", "Sphynx", "Bengal", "Calopsita", "Periquito Australiano", "Agapornis", "Canário", "Cacatua", "Holandês Anão", "Lionhead", "Rex", "Angorá", "Flemish Giant", "Sírio", "Anão Russo", "Roborovski", "Chinês", "Campbell", "Outra"]
    
    static let sizes = ["Mini (Até 6Kg)", "Pequeno (Até 10kg)", "Médio (11 à 24Kg)", "Grande (25 à 45Kg)", "Gigante (Acima de 45Kg)", "Sem porte Pássaro", "Sem porte Peixe", "Sem porte Réptil", "Sem porte Roedor", "Sem porte"]
    
    static let types = ["Cachorro", "Gato", "Pássaro", "Coelho", "Hamster", "Outro"]
}

private enum Constants {
    static let sampleImageURL = "https://img.freepik.com/fotos-gratis/imagem-vertical-de-foco-raso-de-um-filhote-de-cachorro-golden-retriever-fofo-sentado-em-um-gramado_181624-27259.jpg?semt=ais_hybrid&w=740"
}
