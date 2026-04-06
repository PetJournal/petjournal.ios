import SwiftUI

// MARK: - Main Models
struct PetModel: Identifiable, Hashable, Codable {
    let id: String
    let guardian: PetGuardian?
    let specie: Species
    let specieAlias: String?
    let petName: String
    let gender: String
    let breed: Breed
    let breedAlias: String?
    let size: PetSize
    let castrated: Bool
    let dateOfBirth: String
    let image: Data?
    var petImage: Image?
    
    init(
        id: String, guardian: PetGuardian? = nil,
        specie: Species, specieAlias: String? = nil,
        petName: String, gender: String,
        breed: Breed, breedAlias: String? = nil,
        size: PetSize, castrated: Bool,
        dateOfBirth: String, image: Data? = nil, petImage: Image? = nil
    ) {
        self.id = id
        self.guardian = guardian
        self.specie = specie
        self.specieAlias = specieAlias
        self.petName = petName
        self.gender = gender
        self.breed = breed
        self.breedAlias = breedAlias
        self.size = size
        self.castrated = castrated
        self.dateOfBirth = dateOfBirth
        self.image = image
        self.petImage = petImage
    }

    var computedPetImage: Image? {
        if let petImage = petImage {
            return petImage
        }
        if let imageData = image, let uiImage = UIImage(data: imageData) {
            return Image(uiImage: uiImage)
        }
        return nil
    }
}

// MARK: - Protocol Conformance
extension PetModel {
    enum CodingKeys: String, CodingKey {
        case id, guardian, specie, specieAlias, petName, gender, breed, breedAlias, size, castrated, dateOfBirth, image
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        guardian = try container.decodeIfPresent(PetGuardian.self, forKey: .guardian)
        specie = try container.decode(Species.self, forKey: .specie)
        specieAlias = try container.decodeIfPresent(String.self, forKey: .specieAlias)
        petName = try container.decode(String.self, forKey: .petName)
        gender = try container.decode(String.self, forKey: .gender)
        breed = try container.decode(Breed.self, forKey: .breed)
        breedAlias = try container.decodeIfPresent(String.self, forKey: .breedAlias)
        size = try container.decode(PetSize.self, forKey: .size)
        castrated = try container.decode(Bool.self, forKey: .castrated)
        dateOfBirth = try container.decode(String.self, forKey: .dateOfBirth)
        image = try container.decodeIfPresent(Data.self, forKey: .image)
        
        // UI property set to nil when decoding
        petImage = nil
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encodeIfPresent(guardian, forKey: .guardian)
        try container.encode(specie, forKey: .specie)
        try container.encodeIfPresent(specieAlias, forKey: .specieAlias)
        try container.encode(petName, forKey: .petName)
        try container.encode(gender, forKey: .gender)
        try container.encode(breed, forKey: .breed)
        try container.encodeIfPresent(breedAlias, forKey: .breedAlias)
        try container.encode(size, forKey: .size)
        try container.encode(castrated, forKey: .castrated)
        try container.encode(dateOfBirth, forKey: .dateOfBirth)
        try container.encodeIfPresent(image, forKey: .image)
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: PetModel, rhs: PetModel) -> Bool {
        lhs.id == rhs.id
    }
}

// MARK: - Supporting Models
struct Species: Identifiable, Hashable, Codable {
    let id: String
    let name: String
}

struct Breed: Identifiable, Hashable, Codable {
    let id: String
    let name: String
}

struct PetSize: Identifiable, Hashable, Codable {
    let id: String
    let name: String
}
