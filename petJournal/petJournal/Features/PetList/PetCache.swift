import Foundation

struct PetCache {
    private let key = "pets_cache"
    
    func load() -> [PetModel] {
        guard let data = UserDefaultsUtils.get(key: key) as? Data,
              let pets = try? JSONDecoder().decode([PetModel].self, from: data) else {
            return []
        }
        return pets
    }
    
    func save(_ pets: [PetModel]) {
        guard let data = try? JSONEncoder().encode(pets) else { return }
        UserDefaultsUtils.save(value: data, key: key)
    }
}
