import SwiftUI

@MainActor
class PetListViewModel: ObservableObject {
    @Published var pets: [PetModel] = []
    @Published var error: NetworkError?
    
    private let service: PetListServiceProtocol
    private let cacheKey = "cached_pets"
    
    init(service: PetListServiceProtocol = PetListService()) {
        self.service = service
        loadCachedPets()
    }
    
    private func loadCachedPets() {
        guard let data = UserDefaultsUtils.get(key: cacheKey) as? Data,
              let cachedPets = try? JSONDecoder().decode([PetModel].self, from: data) else {
            return
        }
        pets = cachedPets
    }
    
    private func cachePets(_ pets: [PetModel]) {
        guard let data = try? JSONEncoder().encode(pets) else { return }
        UserDefaultsUtils.save(value: data, key: cacheKey)
    }
    
    func fetchPets() async {
        error = nil
        
        do {
            let fetchedPets = try await service.fetchPets()
            let sortedPets = preparePetsForDisplay(fetchedPets)
            pets = sortedPets
            cachePets(sortedPets)
        } catch let error as NetworkError {
            self.error = error
        } catch {
            self.error = .unknown(statusCode: -1)
        }
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
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        guard let date = dateFormatter.date(from: pet.dateOfBirth) else {
            return pet.dateOfBirth
        }
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeZone = TimeZone.current
        return dateFormatter.string(from: date)
    }
    
    func formattedGender(for pet: PetModel) -> String {
        pet.gender.capitalized
    }
    
    func formattedCastratedStatus(for pet: PetModel) -> String {
        pet.castrated ? "Sim" : "Não"
    }
    
    func getImage(for pet: PetModel) -> Image? {
        pet.petImage
    }
}
