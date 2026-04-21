import SwiftUI

struct PetTaskModel: Identifiable, Codable {
    let id: String
    let tagId: String
    let guardianId: String
    let title: String
    let description: String
    let note: String
    let startAt: String
    let endAt: String
    let daysOfWeek: [Int]
    let daysOfMonth: [Int]
    let daily: Bool
    let tag: TagModel?
    let pets: [PetInfo]
    
    var isPast: Bool {
        startAt.isDateInThePast()
    }
}

// MARK: - Task Event Models
struct TaskEvent: Codable {
    let id: String
    let schedulerId: String
    let start: String
    let end: String
    let scheduler: PetTaskModel
}

struct PetInfo: Codable {
    let id: String
    let image: String?
}

// MARK: - Task Response Models

// Generic paginated response
struct PaginatedResponse<T: Codable>: Codable {
    let page: Int
    let limit: Int
    let count: Int?
    let totalPages: Int?
    let data: T
}

// Response for: /tasks/current-date, /tasks/current-week, /tasks/current-month
typealias TaskEventResponse = PaginatedResponse<[TaskEvent]>

// Response for: /tasks/pet/next/{petId}
struct PetNextTasksData: Codable {
    let nextEvents: [TaskEvent]
}

// Response for: /tasks/pet/history/{petId}
struct PetHistoryTasksData: Codable {
    let history: [TaskEvent]
}

// Response for: /tasks/pet/{petId}/tag/{tagId}
struct PetTasksByTagData: Codable {
    let events: [TaskEvent]
}

typealias PetNextTasksResponse = PaginatedResponse<PetNextTasksData>
typealias PetHistoryTasksResponse = PaginatedResponse<PetHistoryTasksData>
typealias PetTasksByTagResponse = PaginatedResponse<PetTasksByTagData>
