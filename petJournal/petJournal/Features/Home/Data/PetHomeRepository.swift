import Foundation

protocol PetHomeRepositoryProtocol {
    func loadCachedData() -> PetHomeData
    func fetchRemoteData() async throws -> PetHomeData
    func saveData(_ data: PetHomeData)
}

struct PetHomeRepository: PetHomeRepositoryProtocol {
    private let petHomeService: PetHomeServiceProtocol
    private let petService: PetServiceProtocol
    private let homeCache = HomeCache()
    private let petCache = PetCache()
    
    init(
        petHomeService: PetHomeServiceProtocol = PetHomeService(),
        petService: PetServiceProtocol = PetService()
    ) {
        self.petHomeService = petHomeService
        self.petService = petService
    }
    
    func loadCachedData() -> PetHomeData {
        let guardian = homeCache.loadGuardian()
        let tags = homeCache.loadTags()
        let pets = petCache.load()
        
        return PetHomeData(
            firstName: guardian?.firstName ?? "",
            lastName: guardian?.lastName ?? "",
            tags: tags,
            pets: pets
        )
    }
    
    func fetchRemoteData() async throws -> PetHomeData {
        async let guardianData = petHomeService.fetchGuardianName()
        async let tagsData = petHomeService.fetchTags()
        async let petsData = petService.fetch()
        
        let (guardian, tags, pets) = try await (guardianData, tagsData, petsData)
        
        return PetHomeData(
            firstName: guardian.firstName,
            lastName: guardian.lastName,
            tags: tags,
            pets: pets
        )
    }
    
    func saveData(_ data: PetHomeData) {
        homeCache.saveGuardian(firstName: data.firstName, lastName: data.lastName)
        homeCache.saveTags(data.tags)
        petCache.save(data.pets)
    }
}

struct PetHomeData {
    let firstName: String
    let lastName: String
    let tags: [TagModel]
    let pets: [PetModel]
    
    func hasChanges(from other: PetHomeData) -> Bool {
        firstName != other.firstName ||
        lastName != other.lastName ||
        !tags.elementsEqual(other.tags, by: { $0.id == $1.id }) ||
        !pets.elementsEqual(other.pets, by: { $0.id == $1.id })
    }
}