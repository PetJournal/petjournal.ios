import SwiftUI

class PetHomeViewModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var tags: [TagModel] = []
    @Published var pets: [PetModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var showAddPetSheet: Bool = false
    @Published var showAddTaskSheet: Bool = false
    
    private let petHomeService: PetHomeServiceProtocol
    private let petService: PetServiceProtocol
    
    init(
        petHomeService: PetHomeServiceProtocol = PetHomeService(),
        petService: PetServiceProtocol = PetService()
    ) {
        self.petHomeService = petHomeService
        self.petService = petService
        self.tags = [createDefaultTag()]
    }
    
    private func createDefaultTag() -> TagModel {
        TagModel(id: "0", name: "Todos", color: "#FFFFFF", image: Image(.icAll), backgroundColor: Color.theme.petPrimary500)
    }
    
    @MainActor
    func loadInitialData() async {
        isLoading = true
        errorMessage = nil
        
        async let guardianData = petHomeService.fetchGuardianName()
        async let tagsData = petHomeService.fetchTags()
        async let petsData = petService.fetch()
        
        do {
            let (guardian, fetchedTags, fetchedPets) = try await (guardianData, tagsData, petsData)
            firstName = guardian.firstName
            lastName = guardian.lastName
            tags = [createDefaultTag()] + fetchedTags
            pets = fetchedPets
        } catch {
            errorMessage = error.localizedDescription
            firstName = "Guardião"
            lastName = ""
        }
        
        isLoading = false
    }
    
    func presentAddPet() {
        showAddPetSheet = true
    }
    
    func presentAddTask() {
        showAddTaskSheet = true
    }
}
