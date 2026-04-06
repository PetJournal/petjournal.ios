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
    
    private let repository: PetHomeRepositoryProtocol
    
    init(repository: PetHomeRepositoryProtocol = PetHomeRepository()) {
        self.repository = repository
        loadCachedData()
    }
    
    private func createDefaultTag() -> TagModel {
        TagModel(id: "0", name: "Todos", color: "#FFFFFF", image: Image(.icAll), backgroundColor: Color.theme.petPrimary500)
    }
    
    private func loadCachedData() {
        let cachedData = repository.loadCachedData()
        updateUI(with: cachedData, animated: false)
        isLoading = isEmpty(cachedData)
    }
    
    private func isEmpty(_ data: PetHomeData) -> Bool {
        data.firstName.isEmpty && data.tags.isEmpty && data.pets.isEmpty
    }
    
    private func updateUI(with data: PetHomeData, animated: Bool) {
        let updateBlock = {
            self.firstName = data.firstName.isEmpty ? "Guardião" : data.firstName
            self.lastName = data.lastName
            self.tags = [self.createDefaultTag()] + data.tags
            self.pets = data.pets
        }
        
        if animated {
            withAnimation(.easeInOut(duration: 0.3)) {
                updateBlock()
            }
        } else {
            updateBlock()
        }
    }
    
    @MainActor
    func loadInitialData() async {
        let currentData = PetHomeData(
            firstName: firstName == "Guardião" ? "" : firstName,
            lastName: lastName,
            tags: Array(tags.dropFirst()),
            pets: pets
        )
        
        if isEmpty(currentData) {
            isLoading = true
        }
        errorMessage = nil
        
        do {
            let newData = try await repository.fetchRemoteData()
            repository.saveData(newData)
            
            if newData.hasChanges(from: currentData) {
                updateUI(with: newData, animated: true)
            }
        } catch {
            errorMessage = error.localizedDescription
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
