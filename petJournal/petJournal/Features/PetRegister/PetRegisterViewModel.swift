import Foundation
import SwiftUI

class PetRegisterViewModel: ObservableObject {
    
    @Published var pet: PetModel = PetModel.makePlaceholder(type: .addPet)
    @Published var isLoading: Bool = false
    @Published var isRequestSuccessful: Bool = false
    @Published var errorMessage: String? = nil
    @Published var registeredPet: PetModel?
    
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
    @Published var image: UIImage = UIImage(named: "pet_logoLightPink")!
    
    // MARK: - ViewModel Functions
    func registerPet() {
        guard isFieldsFilled else { return }
        
        isLoading = true
        errorMessage = nil
        
        // Converter a imagem para Data
        let imageData = image.jpegData(compressionQuality: 0.8)
        
        // Criar o modelo com os dados atuais
        let petToRegister = PetModel(
            id: UUID().uuidString,
            guardian: nil,
            specie: Species(id: UUID().uuidString, name: type ?? ""),
            specieAlias: nil,
            petName: petName,
            gender: gender,
            breed: Breed(id: UUID().uuidString, name: breedName ?? ""),
            breedAlias: nil,
            size: PetSize(id: UUID().uuidString, name: size ?? ""),
            castrated: castrated.lowercased() == "sim",
            dateOfBirth: dateOfBirth,
            image: imageData,
            weight: Double(weight) ?? 0.0
        )
        
        PetRegisterService.registerPet(petToBeRegistered: petToRegister) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let registeredPet):
                    self?.isRequestSuccessful = true
                    self?.registeredPet = registeredPet
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
            image = UIImage(named: "pet_logoLightPink")!
        }
    }
}

//MARK: - Validation
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
