import Foundation

class PetHomeViewModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var showAddPetSheet: Bool = false
    @Published var showAddTaskSheet: Bool = false
    
    private let userService: UserServiceProtocol
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
    }
    
    @MainActor
    func fetchUserData() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let user = try await userService.fetchUserData()
            firstName = user.firstName
            lastName = user.lastName
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
