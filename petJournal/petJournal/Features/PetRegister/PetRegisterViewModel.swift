import Foundation

class PetRegisterViewModel: ObservableObject {
    
    @Published var pet: PetModel = PetModel.addPet
    @Published var isLoading: Bool = false
    @Published var isRequestSuccessful: Bool = false
    @Published var errorMessage: String? = nil
    
    static let shared: PetRegisterViewModel = .init()
    
    func registerPet() {
        isLoading = true
        errorMessage = nil
        
        PetRegisterService.registerPet(petToBeRegistered: pet) { [weak self] result in
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
        if !pet.specie.detail.isEmpty,
           !pet.petName.isEmpty,
           !pet.gender.isEmpty,
           !pet.breed.detail.isEmpty,
           !pet.size.detail.isEmpty,
           !pet.dateOfBirth.isEmpty {
            return true
        } else {
            errorMessage = "Por favor, preencha todos os campos."
            return false
        }
    }
}
