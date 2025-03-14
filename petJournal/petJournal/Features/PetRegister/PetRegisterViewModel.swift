import Foundation

class PetRegisterViewModel: ObservableObject {
    
    @Published var pet: PetModel = PetModel.newPet
    @Published var isLoading: Bool = false
    @Published var isRequestSuccessful: Bool = false
    @Published var errorMessage: String? = nil
    
    private var petService: PetRegisterServiceProtocol!
    init(petService: PetRegisterServiceProtocol) {
        self.petService = petService
    }
    
    func registerPet() {
        isLoading = true
        errorMessage = nil
        
        petService.registerPet(petToBeRegistered: pet) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success:
                    self?.isRequestSuccessful = true
                case .failure(let error):
                    self?.errorMessage = "Erro na requisição: \(error.localizedDescription)"
                }
            }
        }
    }
}

//MARK: - Validation
extension PetRegisterViewModel {
    var isFieldsFilled: Bool {
        if !pet.specieName.isEmpty,
           !pet.petName.isEmpty,
           !pet.gender.isEmpty,
           !pet.breedName.isEmpty,
           !pet.size.isEmpty,
           !pet.dateOfBirth.isEmpty {
            return true
        } else {
            errorMessage = "Por favor, preencha todos os campos."
            return false
        }
    }
}
