import SwiftUI

struct PetTaskModel: Identifiable, Hashable, Codable {
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
    let pets: [PetModel]
    
    // UI properties (not from API)
    let petImages: [Image]?
    let accentColor: Color?
    let backgroundIcon: Image?
    var taskType: TaskType?
    var isPast: Bool
    
    init(id: String, tagId: String, guardianId: String, 
         title: String, description: String, note: String,
         startAt: String, endAt: String, daysOfWeek: [Int],
         daysOfMonth: [Int], daily: Bool, pets: [PetModel],
         petImages: [Image]? = nil, accentColor: Color? = nil,
         backgroundIcon: Image? = nil, taskType: TaskType? = nil) {
        self.id = id
        self.tagId = tagId
        self.guardianId = guardianId
        self.title = title
        self.description = description
        self.note = note
        self.startAt = startAt
        self.endAt = endAt
        self.daysOfWeek = daysOfWeek
        self.daysOfMonth = daysOfMonth
        self.daily = daily
        self.pets = pets
        self.petImages = petImages
        self.accentColor = accentColor
        self.backgroundIcon = backgroundIcon
        self.taskType = taskType
        self.isPast = startAt.isDateInThePast()
    }
    
    enum CodingKeys: String, CodingKey {
        case id, tagId, guardianId, title, description, note, startAt, endAt, daysOfWeek, daysOfMonth, daily, pets
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        tagId = try container.decode(String.self, forKey: .tagId)
        guardianId = try container.decode(String.self, forKey: .guardianId)
        title = try container.decode(String.self, forKey: .title)
        description = try container.decode(String.self, forKey: .description)
        note = try container.decode(String.self, forKey: .note)
        startAt = try container.decode(String.self, forKey: .startAt)
        endAt = try container.decode(String.self, forKey: .endAt)
        daysOfWeek = try container.decode([Int].self, forKey: .daysOfWeek)
        daysOfMonth = try container.decode([Int].self, forKey: .daysOfMonth)
        daily = try container.decode(Bool.self, forKey: .daily)
        pets = try container.decode([PetModel].self, forKey: .pets)
        
        // UI properties set to nil when decoding from API
        petImages = nil
        accentColor = nil
        backgroundIcon = nil
        taskType = nil
        isPast = startAt.isDateInThePast()
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(tagId, forKey: .tagId)
        try container.encode(guardianId, forKey: .guardianId)
        try container.encode(title, forKey: .title)
        try container.encode(description, forKey: .description)
        try container.encode(note, forKey: .note)
        try container.encode(startAt, forKey: .startAt)
        try container.encode(endAt, forKey: .endAt)
        try container.encode(daysOfWeek, forKey: .daysOfWeek)
        try container.encode(daysOfMonth, forKey: .daysOfMonth)
        try container.encode(daily, forKey: .daily)
        try container.encode(pets, forKey: .pets)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: PetTaskModel, rhs: PetTaskModel) -> Bool {
        return lhs.id == rhs.id
    }
}

struct TasksResponse: Codable {
    let page: Int
    let limit: Int
    let totalPages: Int
    let nextEvents: [PetTaskModel]
}

struct HistoricTasksResponse: Codable {
    let page: Int
    let limit: Int
    let totalPages: Int
    let history: [PetTaskModel]
}
