protocol TaskServiceProtocol {
    func fetchUpcomingTasks() async throws -> [PetTaskModel]
    func fetchHistoricTasks() async throws -> [PetTaskModel]
    func fetchCurrentDateTasks() async throws -> [PetTaskModel]
    func fetchCurrentWeekTasks() async throws -> [PetTaskModel]
    func fetchCurrentMonthTasks() async throws -> [PetTaskModel]
    func fetchPetTasksByTag(petId: String, tagId: String) async throws -> [PetTaskModel]
}

class TaskService: TaskServiceProtocol {
    func fetchUpcomingTasks() async throws -> [PetTaskModel] {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.currentDateTasks) else {
            throw NetworkError.invalidURL
        }
        
        let response: TasksResponse = try await NetworkManager.shared.jsonRequest(url: url, method: .get)
        return response.nextEvents
    }
    
    func fetchHistoricTasks() async throws -> [PetTaskModel] {
        // Note: There's no generic historic endpoint in the API, this might need to be implemented differently
        // For now, using current-date as placeholder
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.currentDateTasks) else {
            throw NetworkError.invalidURL
        }
        
        let response: TasksResponse = try await NetworkManager.shared.jsonRequest(url: url, method: .get)
        return response.nextEvents
    }
    
    func fetchCurrentDateTasks() async throws -> [PetTaskModel] {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.currentDateTasks) else {
            throw NetworkError.invalidURL
        }
        
        let response: TasksResponse = try await NetworkManager.shared.jsonRequest(url: url, method: .get)
        return response.nextEvents
    }
    
    func fetchCurrentWeekTasks() async throws -> [PetTaskModel] {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.currentWeekTasks) else {
            throw NetworkError.invalidURL
        }
        
        let response: TasksResponse = try await NetworkManager.shared.jsonRequest(url: url, method: .get)
        return response.nextEvents
    }
    
    func fetchCurrentMonthTasks() async throws -> [PetTaskModel] {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.currentMonthTasks) else {
            throw NetworkError.invalidURL
        }
        
        let response: TasksResponse = try await NetworkManager.shared.jsonRequest(url: url, method: .get)
        return response.nextEvents
    }
    
    func fetchPetTasksByTag(petId: String, tagId: String) async throws -> [PetTaskModel] {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.petTasksByTag(petId, tagId)) else {
            throw NetworkError.invalidURL
        }
        
        let response: TasksResponse = try await NetworkManager.shared.jsonRequest(url: url, method: .get)
        return response.nextEvents
    }
}