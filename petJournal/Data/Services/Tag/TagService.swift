struct TagRegisterRequest: Codable {
    let name: String
    let color: String
}

struct TagUpdateRequest: Codable {
    let name: String
    let color: String
}

protocol TagServiceProtocol {
    func fetchTags() async throws -> [TagModel]
    func registerTag(_ tagRequest: TagRegisterRequest) async throws -> TagModel
    func update(_ tag: TagModel) async throws -> TagModel
    func fetchTagByID(_ tagId: String) async throws -> TagModel
    func delete(_ tagId: String) async throws
}

class TagService: TagServiceProtocol {
    func fetchTags() async throws -> [TagModel] {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.tag) else {
            throw NetworkError.invalidURL
        }
        
        return try await NetworkManager.shared.jsonRequest(
            url: url,
            method: .get)
    }
    
    func registerTag(_ tagRequest: TagRegisterRequest) async throws -> TagModel {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.tag) else {
            throw NetworkError.invalidURL
        }
        
        return try await NetworkManager.shared.jsonRequest(
            url: url,
            method: .post,
            body: tagRequest
        )
    }
    
    func update(_ tag: TagModel) async throws -> TagModel {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.tagByID(tag.id)) else {
            throw NetworkError.invalidURL
        }
        
        let updateRequest = TagUpdateRequest(name: tag.name, color: tag.color)
        return try await NetworkManager.shared.jsonRequest(
            url: url,
            method: .put,
            body: updateRequest
        )
    }
    
    func fetchTagByID(_ tagID: String) async throws -> TagModel {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.tagByID(tagID)) else {
            throw NetworkError.invalidURL
        }
        
        return try await NetworkManager.shared.jsonRequest(
            url: url,
            method: .get)
    }
    
    func delete(_ tagID: String) async throws {
        guard let url = URLManager.shared.makeURL(path: URLManager.shared.tagByID(tagID)) else {
            throw NetworkError.invalidURL
        }
        
        let _: EmptyResponse = try await NetworkManager.shared.request(
            url: url,
            method: .delete
        )
    }
}

