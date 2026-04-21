import Foundation

// MARK: - TaskService Mock Data
extension TaskService {
    static func mock() -> MockTaskService {
        return MockTaskService()
    }
}

class MockTaskService: TaskServiceProtocol {
    func fetchUpcomingTasks() async throws -> [PetTaskModel] {
        return PetTaskModel.previewList
    }
    
    func fetchHistoricTasks() async throws -> [PetTaskModel] {
        return PetTaskModel.previewHistoric
    }
    
    func fetchCurrentDateTasks() async throws -> [PetTaskModel] {
        return PetTaskModel.previewList
    }
    
    func fetchCurrentWeekTasks() async throws -> [PetTaskModel] {
        return PetTaskModel.previewList
    }
    
    func fetchCurrentMonthTasks() async throws -> [PetTaskModel] {
        return PetTaskModel.previewList
    }
    
    func fetchPetNextTasks(petId: String) async throws -> [PetTaskModel] {
        return PetTaskModel.previewList
    }
    
    func fetchPetHistoryTasks(petId: String) async throws -> [PetTaskModel] {
        return PetTaskModel.previewHistoric
    }
    
    func fetchPetTasksByTag(petId: String, tagId: String) async throws -> [PetTaskModel] {
        return PetTaskModel.previewList.filter { $0.tagId == tagId }
    }
}