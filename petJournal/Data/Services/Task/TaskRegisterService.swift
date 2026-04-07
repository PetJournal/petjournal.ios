// MARK: - Request Model
struct TaskRegisterRequest: Codable {
    let tagId: String
    let title: String
    let description: String
    let note: String
    let startAt: String
    let endAt: String
    let daysOfWeek: [Int]
    let daysOfMonth: [Int]
    let daily: Bool
    let pets: [String]
}

// MARK: - Protocol
protocol TaskRegisterServiceProtocol {
    func register(_ request: TaskRegisterRequest) async throws -> PetTaskModel
}

// MARK: - Service Implementation
extension TaskService: TaskRegisterServiceProtocol {
    func register(_ request: TaskRegisterRequest) async throws -> PetTaskModel {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.scheduler) else {
            throw NetworkError.invalidURL
        }
        
        return try await NetworkManager.shared.jsonRequest(
            url: url,
            method: .post,
            body: request
        )
    }
}
