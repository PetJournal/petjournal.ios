protocol TaskServiceProtocol {
    func fetchUpcomingTasks() async throws -> [PetTaskModel]
    func fetchHistoricTasks() async throws -> [PetTaskModel]
    func fetchCurrentDateTasks() async throws -> [PetTaskModel]
    func fetchCurrentWeekTasks() async throws -> [PetTaskModel]
    func fetchCurrentMonthTasks() async throws -> [PetTaskModel]
    func fetchPetNextTasks(petId: String) async throws -> [PetTaskModel]
    func fetchPetHistoryTasks(petId: String) async throws -> [PetTaskModel]
    func fetchPetTasksByTag(petId: String, tagId: String) async throws -> [PetTaskModel]
}

class TaskService: TaskServiceProtocol {
    func fetchUpcomingTasks() async throws -> [PetTaskModel] {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.currentDateTasks) else {
            throw NetworkError.invalidURL
        }
        
        let response: TaskEventResponse = try await NetworkManager.shared.jsonRequest(url: url, method: .get)
        return response.data.map { $0.scheduler }
    }
    
    func fetchHistoricTasks() async throws -> [PetTaskModel] {
        // TODO: Use fetchPetHistoryTasks with specific petId when needed
        return []
    }
    
    func fetchCurrentDateTasks() async throws -> [PetTaskModel] {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.currentDateTasks) else {
            throw NetworkError.invalidURL
        }
        
        let response: TaskEventResponse = try await NetworkManager.shared.jsonRequest(url: url, method: .get)
        return response.data.map { $0.scheduler }
    }
    
    func fetchCurrentWeekTasks() async throws -> [PetTaskModel] {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.currentWeekTasks) else {
            throw NetworkError.invalidURL
        }
        
        let response: TaskEventResponse = try await NetworkManager.shared.jsonRequest(url: url, method: .get)
        return response.data.map { $0.scheduler }
    }
    
    func fetchCurrentMonthTasks() async throws -> [PetTaskModel] {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.currentMonthTasks) else {
            throw NetworkError.invalidURL
        }
        
        let response: TaskEventResponse = try await NetworkManager.shared.jsonRequest(url: url, method: .get)
        return response.data.map { $0.scheduler }
    }
    
    func fetchPetNextTasks(petId: String) async throws -> [PetTaskModel] {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.petUpcomingTasks(petId)) else {
            throw NetworkError.invalidURL
        }
        
        let response: PetNextTasksResponse = try await NetworkManager.shared.jsonRequest(url: url, method: .get)
        return response.data.nextEvents.map { $0.scheduler }
    }
    
    func fetchPetHistoryTasks(petId: String) async throws -> [PetTaskModel] {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.petHistoricTasks(petId)) else {
            throw NetworkError.invalidURL
        }
        
        let response: PetHistoryTasksResponse = try await NetworkManager.shared.jsonRequest(url: url, method: .get)
        return response.data.history.map { $0.scheduler }
    }
    
    func fetchPetTasksByTag(petId: String, tagId: String) async throws -> [PetTaskModel] {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.petTasksByTag(petId, tagId)) else {
            throw NetworkError.invalidURL
        }
        
        let response: PetTasksByTagResponse = try await NetworkManager.shared.jsonRequest(url: url, method: .get)
        return response.data.events.map { $0.scheduler }
    }
}