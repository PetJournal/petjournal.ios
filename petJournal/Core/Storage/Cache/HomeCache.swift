import Foundation

struct HomeCache {
    private let tagsKey = "home_tags_cache"
    private let guardianKey = "home_guardian_cache"
    
    func loadTags() -> [TagModel] {
        guard let data = UserDefaultsUtils.get(key: tagsKey) as? Data,
              let tags = try? JSONDecoder().decode([TagModel].self, from: data) else {
            return []
        }
        return tags
    }
    
    func saveTags(_ tags: [TagModel]) {
        guard let data = try? JSONEncoder().encode(tags) else { return }
        UserDefaultsUtils.save(value: data, key: tagsKey)
    }
    
    func loadGuardian() -> (firstName: String, lastName: String)? {
        guard let data = UserDefaultsUtils.get(key: guardianKey) as? Data,
              let guardian = try? JSONDecoder().decode(GuardianCache.self, from: data) else {
            return nil
        }
        return (guardian.firstName, guardian.lastName)
    }
    
    func saveGuardian(firstName: String, lastName: String) {
        let guardian = GuardianCache(firstName: firstName, lastName: lastName)
        guard let data = try? JSONEncoder().encode(guardian) else { return }
        UserDefaultsUtils.save(value: data, key: guardianKey)
    }
}

private struct GuardianCache: Codable {
    let firstName: String
    let lastName: String
}