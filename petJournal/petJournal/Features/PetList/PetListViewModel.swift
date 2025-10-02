import SwiftUI

@MainActor
class PetListViewModel: ObservableObject {
    @Published var pets: [PetModel] = []
    @Published var error: NetworkError?
    
    private let service: PetServiceProtocol
    private let cache = PetCache()
    
    init(service: PetServiceProtocol = PetService()) {
        self.service = service
        pets = cache.load()
    }
    
    func fetch() async {
        error = nil
        
        do {
            let fetchedPets = try await service.fetch()
            let sortedPets = fetchedPets.sorted { $0.petName < $1.petName }
            pets = sortedPets
            cache.save(sortedPets)
        } catch let networkError as NetworkError {
            self.error = networkError
        } catch {
            self.error = .unknown(statusCode: -1)
        }
    }
}


