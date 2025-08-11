import Foundation
import SwiftUI

class PetRegisterViewModel: ObservableObject {
    
    @Published var pet: PetModel = PetModel.makePlaceholder(type: .addPet)
    @Published var isLoading: Bool = false
    @Published var isRequestSuccessful: Bool = false
    @Published var errorMessage: String? = nil
    
    static let shared: PetRegisterViewModel = .init()
    
    // MARK: - Mock de Estado para a PetRegisterView (seguindo os nomes de PetModel)
    @Published var petName: String = ""
    @Published var breedName: String? = nil
    @Published var size: String? = nil
    @Published var dateOfBirth: String = ""
    @Published var weight: String = ""
    @Published var type: String? = nil
    @Published var gender: String = ""
    @Published var castrated: String = ""
    @Published var image: UIImage = UIImage(named: "banner_01")!
    
    // MARK: - ViewModel Functions
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
    
    func getBreed() -> [String] {
        return ["Labrador", "Lhasa Apso", "Shit Zhu", "Golden", "Sem raça definida"]
    }
    
    func getSize() -> [String] {
        return ["Pequeno", "Médio", "Grande"]
    }
    
    func getAnimalType() -> [String] {
        return ["Cão", "Gato", "Pássaro"]
    }
    
    func getImage() async {
        do {
            guard let imageFetched = try await AsyncImageService.asyncImage(from: "https://img.freepik.com/fotos-gratis/imagem-vertical-de-foco-raso-de-um-filhote-de-cachorro-golden-retriever-fofo-sentado-em-um-gramado_181624-27259.jpg?semt=ais_hybrid&w=740") else {
                return
            }
            image = imageFetched
        } catch {
            image = UIImage(named: "banner_01")!
        }
    }
}

//MARK: - Validation
extension PetRegisterViewModel {
    var isFieldsFilled: Bool {
        if !pet.specie.name.isEmpty,
           !pet.petName.isEmpty,
           !pet.gender.isEmpty,
           !pet.breed.name.isEmpty,
           !pet.size.name.isEmpty,
           !pet.dateOfBirth.isEmpty {
            return true
        } else {
            errorMessage = "Por favor, preencha todos os campos."
            return false
        }
    }
}
