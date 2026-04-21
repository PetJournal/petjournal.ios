import SwiftUI

enum TaskFrequency: String, CaseIterable {
    case daily = "Diária"
    case weekly = "Semanal"
    case monthly = "Mensal"
}

@MainActor
class TaskListViewModel: ObservableObject {
    @Published var tasks: [PetTaskModel] = []
    @Published var historicTasks: [PetTaskModel] = []
    @Published var isLoading = false
    @Published var error: NetworkError?
    
    private let service: TaskServiceProtocol
    let filterTag: TagModel?
    
    init(service: TaskServiceProtocol = TaskService(), filterTag: TagModel? = nil) {
        self.service = service
        self.filterTag = filterTag
    }
    
    var filteredTasks: [PetTaskModel] {
        guard let filterTag = filterTag else { return tasks }
        
        return tasks.filter { task in
            guard let taskTag = task.tag else { return false }
            return taskTag.id == filterTag.id
        }
    }
    
    func groupedTasks(by frequency: TaskFrequency) -> [String: [PetTaskModel]] {
        let groupingKey: (PetTaskModel) -> String = {
            switch frequency {
            case .daily: return $0.startAt.toISOFormat()
            case .weekly: return $0.startAt.toISOWeekFormat()
            case .monthly: return $0.startAt.toISOMonthFormat()
            }
        }
        return Dictionary(grouping: filteredTasks, by: groupingKey)
    }
    
    var pastTasks: [PetTaskModel] {
        let currentDate = Date()
        return filteredTasks.filter { $0.startAt.toDate() ?? Date() < currentDate }
    }
    
    func fetchTasks() async {
        isLoading = true
        error = nil
        
        do {
            let fetchedTasks = try await service.fetchUpcomingTasks()
            tasks = fetchedTasks
        } catch let networkError as NetworkError {
            self.error = networkError
        } catch {
            self.error = .unknown(statusCode: -1)
        }
        
        isLoading = false
    }
    
    func fetchHistoricTasks() async {
        // TODO: API endpoint for historic tasks is still under construction
        // Temporarily disabled to avoid duplicate calls
//        do {
//            let fetchedHistoricTasks = try await service.fetchHistoricTasks()
//            historicTasks = fetchedHistoricTasks
//        } catch let networkError as NetworkError {
//            self.error = networkError
//        } catch {
//            self.error = .unknown(statusCode: -1)
//        }
    }
}