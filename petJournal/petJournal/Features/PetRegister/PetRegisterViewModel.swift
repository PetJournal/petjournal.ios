import SwiftUI

class PetRegisterViewModel: ObservableObject {
    
    @Published var isLoading: Bool = false
    @Published var isRequestSuccessful: Bool = false
    @Published var errorMessage: String? = nil
    @Published var pet: PetModel?
    
    @Published var petName: String = ""
    @Published var breedName: String? = nil
    @Published var size: String? = nil
    @Published var dateOfBirth: String = ""
//    @Published var weight: String = ""
    @Published var type: String? = nil
    @Published var gender: String = ""
    @Published var castrated: String = ""
    @Published var image: UIImage = UIImage()

    private let petRegisterService: PetRegisterServiceProtocol
    static let shared: PetRegisterViewModel = .init()
    
    init(service: PetRegisterServiceProtocol = PetRegisterService()) {
        self.petRegisterService = service
    }
}

// MARK: - Public Methods
extension PetRegisterViewModel {
    func registerPet() async {
        guard isFieldsFilled else { return }
        
        await setLoadingState(true)
        
        do {
            let petToRegister = createPetModel()
            let pet = try await petRegisterService.registerPet(petToBeRegistered: petToRegister)
            
            await handleSuccess(registeredPet: pet)
        } catch {
            await handleError(error)
        }
    }
    
    func getImage() async {
        do {
            guard let imageFetched = try await AsyncImageService.asyncImage(from: Constants.imageURL) else { return }
            await setImage(imageFetched)
        } catch {
            debugPrint("No image found")
        }
    }
    
    func getBreed() -> [String] {
        return ["Labrador Retriever","Bulldog Francês",
                "Golden Retriever","Poodle",
                "Shih Tzu","Siamês",
                "Persa","Maine Coon",
                "Sphynx","Bengal","Calopsita",
                "Periquito Australiano","Agapornis",
                "Canário","Cacatua","Holandês Anão",
                "Lionhead","Rex","Angorá",
                "Flemish Giant","Sírio",
                "Anão Russo","Roborovski","Chinês",
                "Campbell","Outra"]
    }
    
    func getSize() -> [String] {
        return ["Mini (Até 6Kg)", "Pequeno (Até 10kg)",
                "Médio (11 à 24Kg)", "Grande (25 à 45Kg)",
                "Gigante (Acima de 45Kg)","Sem porte Pássaro","Sem porte Peixe",
                "Sem porte Réptil","Sem porte Roedor","Sem porte", ]
    }
    
    func getAnimalType() -> [String] {
        return ["Cachorro","Gato","Pássaro",
            "Coelho","Hamster","Outro"]
    }
    
    func populateFields(with pet: PetModel) {
        self.pet = pet
        petName = pet.petName
        breedName = pet.breed.name
        size = pet.size.name
        dateOfBirth = pet.dateOfBirth
//        weight = pet.weight ?? ""
        type = pet.specie.name
        gender = pet.gender
        castrated = pet.castrated ? "Sim" : "Não"
    }
}

// MARK: - Private Methods
private extension PetRegisterViewModel {
    func createPetModel() -> PetModel {
        let imageData = image.jpegData(compressionQuality: 0.8)
        
        return PetModel(
            id: UUID().uuidString,
            guardianId: nil,
            specie: Species(id: UUID().uuidString, name: type ?? ""),
            specieAlias: nil,
            petName: petName,
            gender: gender,
            breed: Breed(id: UUID().uuidString, name: breedName ?? ""),
            breedAlias: nil,
            size: PetSize(id: UUID().uuidString, name: size ?? ""),
            castrated: castrated.lowercased() == "sim",
            dateOfBirth: dateOfBirth.toAPIDateFormat() ?? dateOfBirth,
            image: imageData
        )
    }
    
    @MainActor
    func setLoadingState(_ loading: Bool) {
        isLoading = loading
        if loading {
            errorMessage = nil
        }
    }
    
    @MainActor
    func handleSuccess(registeredPet: PetModel) {
        isRequestSuccessful = true
        self.pet = registeredPet
        isLoading = false
    }
    
    @MainActor
    func handleError(_ error: Error) {
        errorMessage = error.localizedDescription
        isLoading = false
    }
    
    @MainActor
    func setImage(_ image: UIImage?) {
        if let image = image, var currentPet = self.pet {
            currentPet.petImage = Image(uiImage: image)
            self.pet = currentPet
        }
    }
}

// MARK: - Validation
extension PetRegisterViewModel {
    var isFieldsFilled: Bool {
        let requiredFields: [Bool] = [
            !petName.isEmpty,
            !gender.isEmpty,
            !(type?.isEmpty ?? true),
            !(breedName?.isEmpty ?? true),
            !(size?.isEmpty ?? true),
            !dateOfBirth.isEmpty,
            !castrated.isEmpty
        ]
        
        if requiredFields.allSatisfy({ $0 }) {
            return true
        } else {
            errorMessage = "Por favor, preencha todos os campos obrigatórios."
            return false
        }
    }
}

// MARK: - Constants
private enum Constants {
    static let imageURL = "https://img.freepik.com/fotos-gratis/imagem-vertical-de-foco-raso-de-um-filhote-de-cachorro-golden-retriever-fofo-sentado-em-um-gramado_181624-27259.jpg?semt=ais_hybrid&w=740"
}
