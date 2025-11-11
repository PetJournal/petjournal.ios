import SwiftUI

class PetProfileViewModel: ObservableObject {
    @Published var tasks: [TaskResponse] = []
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
            let fetchedTasks = try await service.fetchTasks(for: petId)
            await MainActor.run {
                self.tasks = fetchedTasks
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

struct TaskResponse: Codable {
    let id: String
    let schedulerId: String
    let start: String
    let end: String
    let page: Int
    let limit: Int
    let count: Int
}

extension TaskResponse {
    func toPetTaskModel() -> PetTaskModel {
        return PetTaskModel(
            title: "Task \(id.prefix(8))",
            schedule: formatSchedule(),
            description: "Scheduler ID: \(schedulerId)",
            petImages: [],
            accentColor: Color.theme.petPrimary500,
            backgroundIcon: Image(.icMedicine),
            taskType: .all,
            startAt: start
        )
    }
    
    private func formatSchedule() -> String {
        let formatter = ISO8601DateFormatter()
        if let date = formatter.date(from: start) {
            let displayFormatter = DateFormatter()
            displayFormatter.dateStyle = .short
            displayFormatter.timeStyle = .short
            return displayFormatter.string(from: date)
        }
        return start
    }
}
