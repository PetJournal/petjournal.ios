import SwiftUI

@MainActor
class PetListViewModel: ObservableObject {
    @Published var pets: [PetModel] = []
    @Published var isLoading = false
    @Published var error: NetworkError?
    
    static let shared: PetListViewModel = .init()
    
    private let service: PetListServiceProtocol
    
    init(service: PetListServiceProtocol = PetListService()) {
        self.service = service
    }
    
    func fetchPets() async {
        isLoading = true
        error = nil
        
        do {
            let fetchedPets = try await service.fetchPets()
            pets = preparePetsForDisplay(fetchedPets)
        } catch let error as NetworkError {
            self.error = error
        } catch {
            self.error = .unknown(statusCode: -1)
        }
        
        isLoading = false
    }
}

// MARK: - Data Preparation
private extension PetListViewModel {
    func preparePetsForDisplay(_ pets: [PetModel]) -> [PetModel] {
        pets.sorted { $0.petName < $1.petName }
    }
}

// MARK: - Formatting Utilities
extension PetListViewModel {
    func formattedDateOfBirth(for pet: PetModel) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        guard let date = dateFormatter.date(from: pet.dateOfBirth) else {
            return pet.dateOfBirth
        }
        
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    
    func formattedGender(for pet: PetModel) -> String {
        pet.gender.capitalized
    }
    
    func formattedCastratedStatus(for pet: PetModel) -> String {
        pet.castrated ? "Sim" : "Não"
    }
    
    func getImage(for pet: PetModel) -> PetImage {
        pet.petImage
    }
}
