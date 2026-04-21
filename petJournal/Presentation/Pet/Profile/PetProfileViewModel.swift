import SwiftUI

class PetProfileViewModel: ObservableObject {
    @Published var upcomingTasks: [PetTaskModel] = []
    @Published var historicTasks: [PetTaskModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    
    private let service: PetProfileServiceProtocol
    private let petId: String
    
    init(petId: String, service: PetProfileServiceProtocol = PetProfileService()) {
        self.petId = petId
        self.service = service
    }
    
    func loadTasks() async {
        await setLoading(true)
        
        do {
            async let upcomingResponse = service.fetchUpcomingTasks(for: petId)
            async let historicResponse = service.fetchHistoricTasks(for: petId)
            
            let (upcoming, historic) = try await (upcomingResponse, historicResponse)
            
            await MainActor.run {
                self.upcomingTasks = upcoming.data.nextEvents.map { $0.scheduler }
                self.historicTasks = historic.data.history.map { $0.scheduler }
                self.errorMessage = nil
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
            }
        }
        
        await setLoading(false)
    }
    
    @MainActor
    private func setLoading(_ loading: Bool) {
        isLoading = loading
    }
}
