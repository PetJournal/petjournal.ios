import Foundation
import SwiftUI

class PetRegisterViewModel: ObservableObject {
    
    @Published var pet: PetModel = PetModel.addPet
    @Published var isLoading: Bool = false
    @Published var isRequestSuccessful: Bool = false
    @Published var errorMessage: String? = nil
    
    static let shared: PetRegisterViewModel = .init()
    
    // MARK: - Mock de Estado para a PetRegisterView (seguindo os nomes de PetModel)
    @Published var petName: String = ""
    @Published var breedName: String? = nil
    @Published var size: String = ""
    @Published var dateOfBirth: String = ""
    @Published var weight: String = ""
    @Published var type: String = ""
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
