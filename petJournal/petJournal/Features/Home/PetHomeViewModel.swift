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
    
    private let userService: UserServiceProtocol
    private let petHomeService: PetHomeServiceProtocol
    private let petService: PetServiceProtocol
    
    init(
        userService: UserServiceProtocol = UserService(),
        petHomeService: PetHomeServiceProtocol = PetHomeService(),
        petService: PetServiceProtocol = PetService()
    ) {
        self.userService = userService
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
        
        async let userData = userService.fetchUserData()
        async let tagsData = petHomeService.fetchTags()
        async let petsData = petService.fetch()
        
        do {
            let (user, fetchedTags, fetchedPets) = try await (userData, tagsData, petsData)
            firstName = user.firstName
            lastName = user.lastName
            tags = [createDefaultTag()] + fetchedTags
            pets = fetchedPets
        } catch {
            errorMessage = error.localizedDescription
            firstName = "Time"
            lastName = "iOS"
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

// Protocol for dependency injection and testing
protocol UserServiceProtocol {
    func fetchUserData() async throws -> User
}

// Mock service implementation
struct UserService: UserServiceProtocol {
    func fetchUserData() async throws -> User {
        try await Task.sleep(nanoseconds: 2_000_000_000)
        if Bool.random() {
            return User(firstName: "Time", lastName: "iOS")
        } else {
            throw NSError(domain: "com.pethome.error", code: 1, userInfo: [NSLocalizedDescriptionKey: "Failed to fetch user data"])
        }
    }
}

struct User {
    let firstName: String
    let lastName: String
}
