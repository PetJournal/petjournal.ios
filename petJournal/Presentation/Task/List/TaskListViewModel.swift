import SwiftUI

@MainActor
class TaskListViewModel: ObservableObject {
    @Published var tasks: [PetTaskModel] = []
    @Published var historicTasks: [PetTaskModel] = []
    @Published var isLoading = false
    @Published var error: NetworkError?
    
    private let service: TaskServiceProtocol
    let filterType: TaskType
    
    init(service: TaskServiceProtocol = TaskService(), filterType: TaskType = .all) {
        self.service = service
        self.filterType = filterType
    }
    
    var filteredTasks: [PetTaskModel] {
        filterType == .all ? tasks : tasks.filter { $0.taskType == filterType }
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
        do {
            let fetchedHistoricTasks = try await service.fetchHistoricTasks()
            historicTasks = fetchedHistoricTasks
        } catch let networkError as NetworkError {
            self.error = networkError
        } catch {
            self.error = .unknown(statusCode: -1)
        }
    }
}