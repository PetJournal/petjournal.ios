import SwiftUI
import Combine

class PetListViewModel: ObservableObject {
    @Published var pets: [PetModel] = []
    @Published var isLoading = false
    @Published var error: Error?
    
    private var cancellables = Set<AnyCancellable>()
    static let shared: PetListViewModel = .init()
    
    func fetchPets() {
        isLoading = true
        error = nil
        
        PetListService.fetchPets { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                
                switch result {
                case .success(let pets):
                    self?.pets = self?.preparePetsForDisplay(pets) ?? []
                case .failure(let error):
                    self?.error = error
                    print("Error fetching pets: \(error.localizedDescription)")
                }
            }
        }
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
