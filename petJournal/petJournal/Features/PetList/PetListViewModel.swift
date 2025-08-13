import SwiftUI
import Combine

class PetListViewModel: ObservableObject {
    @Published var pets: [PetModel] = []
    @Published var isLoading = false
    @Published var error: NetworkError?
    static let shared: PetListViewModel = .init()
    
    private let service: PetListServiceProtocol
    
    init(service: PetListServiceProtocol = PetListService()) {
        self.service = service
    }
    
    @MainActor
    func fetchPets() async {
        isLoading = true
        error = nil
        
        do {
            pets = try await service.fetchPets()
        } catch let error as NetworkError {
            self.error = error
        } catch {
            self.error = .unknown(statusCode: -1)
        }
        
        isLoading = false
    }
    // Here we sort by pet name
    private func preparePetsForDisplay(_ pets: [PetModel]) -> [PetModel] {
        return pets.sorted { $0.petName < $1.petName }
    }
    // Helper function to get the image if available
    func getImage(for pet: PetModel) -> PetImage {
        return pet.petImage
    }
    
    // Format date of birth for display
    func formattedDateOfBirth(for pet: PetModel) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd-MM-yyyy"
        
        guard let date = dateFormatter.date(from: pet.dateOfBirth) else {
            return pet.dateOfBirth
        }
        
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
    }
    
    // Format gender for display
    func formattedGender(for pet: PetModel) -> String {
        return pet.gender.capitalized
    }
    
    // Format castrated status for display
    func formattedCastratedStatus(for pet: PetModel) -> String {
        return pet.castrated ? "Sim" : "Não"
    }
}
