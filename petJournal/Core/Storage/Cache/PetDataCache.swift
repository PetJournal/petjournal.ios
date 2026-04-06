import Foundation

struct PetDataCache {
    private let dogBreedsKey = "dog_breeds_cache"
    private let catBreedsKey = "cat_breeds_cache"
    private let dogSizesKey = "dog_sizes_cache"
    private let catSizesKey = "cat_sizes_cache"
    
    func loadBreeds(for type: String) -> [String] {
        let key = type == "Cachorro" ? dogBreedsKey : catBreedsKey
        guard let data = UserDefaultsUtils.get(key: key) as? Data,
              let breeds = try? JSONDecoder().decode([String].self, from: data) else {
            return []
        }
        return breeds
    }
    
    func saveBreeds(_ breeds: [String], for type: String) {
        let key = type == "Cachorro" ? dogBreedsKey : catBreedsKey
        guard let data = try? JSONEncoder().encode(breeds) else { return }
        UserDefaultsUtils.save(value: data, key: key)
    }
    
    func loadSizes(for type: String) -> [String] {
        let key = type == "Cachorro" ? dogSizesKey : catSizesKey
        guard let data = UserDefaultsUtils.get(key: key) as? Data,
              let sizes = try? JSONDecoder().decode([String].self, from: data) else {
            return []
        }
        return sizes
    }
    
    func saveSizes(_ sizes: [String], for type: String) {
        let key = type == "Cachorro" ? dogSizesKey : catSizesKey
        guard let data = try? JSONEncoder().encode(sizes) else { return }
        UserDefaultsUtils.save(value: data, key: key)
    }
}