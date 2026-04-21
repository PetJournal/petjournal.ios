import Foundation

protocol PetProfileServiceProtocol {
    func fetchUpcomingTasks(for petId: String) async throws -> PetNextTasksResponse
    func fetchHistoricTasks(for petId: String) async throws -> PetHistoryTasksResponse
}

class PetProfileService: PetProfileServiceProtocol {
    func fetchUpcomingTasks(for petId: String) async throws -> PetNextTasksResponse {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.petUpcomingTasks(petId)) else {
            throw NetworkError.invalidURL
        }
        
        return try await NetworkManager.shared.jsonRequest(url: url, method: .get)
    }
    
    func fetchHistoricTasks(for petId: String) async throws -> PetHistoryTasksResponse {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.petHistoricTasks(petId)) else {
            throw NetworkError.invalidURL
        }
        
        return try await NetworkManager.shared.jsonRequest(url: url, method: .get)
    }
}
