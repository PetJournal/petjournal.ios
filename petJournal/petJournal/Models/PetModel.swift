import Foundation
import SwiftUI

// MARK: - Main Models
struct PetModel: Identifiable, Hashable, Codable {
    let id: String
    let guardianId: String?
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
    
    // Propriedades computadas para placeholders
    let weight: Double?
    var isAddPetPlaceholder: Bool = false
    var allPetsPlaceholder: Bool = false
    var isSelected: Bool = false
    
    // Inicializador personalizado
    init(
        id: String, guardianId: String? = nil,
        specie: Species, specieAlias: String? = nil,
        petName: String, gender: String,
        breed: Breed, breedAlias: String? = nil,
        size: PetSize, castrated: Bool,
        dateOfBirth: String, image: Data? = nil,
        weight: Double? = nil, isAddPetPlaceholder: Bool = false,
        allPetsPlaceholder: Bool = false, isSelected: Bool = false
    ) {
        self.id = id
        self.guardianId = guardianId
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
        self.weight = weight
        self.isAddPetPlaceholder = isAddPetPlaceholder
        self.allPetsPlaceholder = allPetsPlaceholder
        self.isSelected = isSelected
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        guardianId = try container.decodeIfPresent(String.self, forKey: .guardianId)
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
        
        //Propriedades que não vêm da API
        weight = nil
        isAddPetPlaceholder = false
        allPetsPlaceholder = false
        isSelected = false
    }
    
    // Computed property para imagens
    var petImage: PetImage {
        if isAddPetPlaceholder {
            return .image(Image(asset: .addSignal))
        } else if allPetsPlaceholder {
            return .image(Image(asset: isSelected ? .petSelected : .petUnselected))
        } else if let imageString = self.image, !imageString.isEmpty,
           let imageData = Data(base64Encoded: imageString),
           let uiImage = UIImage(data: imageData) {
            return .image(Image(uiImage: uiImage))
        } else {
            return .placeholder
        }
    }
}

// MARK: - Supporting Models
struct Guardian: Identifiable, Hashable, Codable {
    let id: String
    let firstName: String
    let lastName: String
    let email: String
    let phone: String
}

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

// MARK: - Image Handling
enum PetImage {
    case image(Image)
    case systemSymbol(String)
    case placeholder
    
    var image: Image {
        switch self {
        case .image(let image):
            return image
        case .systemSymbol(let symbol):
            return Image(systemName: symbol)
        case .placeholder:
            return PetModel.samplePetImages.randomElement()!
        }
    }
}

// MARK: - Factory Methods & Sample Data
extension PetModel {
    static func makePlaceholder(type: PlaceholderType, 
                                isSelected: Bool = false) -> PetModel {
        return PetModel(
            id: UUID().uuidString,
            guardianId: nil,
            specie: Species(id: UUID().uuidString, name: ""),
            specieAlias: nil,
            petName: type.displayName,
            gender: "",
            breed: Breed(id: UUID().uuidString, name: ""),
            breedAlias: nil,
            size: PetSize(id: UUID().uuidString, name: ""),
            castrated: false,
            dateOfBirth: "",
            image: nil,
            weight: 0,
            isAddPetPlaceholder: type == .addPet,
            allPetsPlaceholder: type == .allPets,
            isSelected: isSelected
        )
    }
    
    enum PlaceholderType {
        case addPet
        case allPets
        
        var displayName: String {
            switch self {
            case .addPet: return "Adicionar"
            case .allPets: return "Todos"
            }
        }
    }
    
    static func makeSamplePet(
        name: String,
        species: String,
        breed: String,
        size: String,
        gender: String,
        isCastrated: Bool,
        dateOfBirth: String,
        weight: Double?
    ) -> PetModel {
        return PetModel(
            id: UUID().uuidString,
            guardianId: nil,
            specie: Species(id: UUID().uuidString, name: species),
            specieAlias: nil,
            petName: name,
            gender: gender,
            breed: Breed(id: UUID().uuidString, name: breed),
            breedAlias: nil,
            size: PetSize(id: UUID().uuidString, name: size),
            castrated: isCastrated,
            dateOfBirth: dateOfBirth,
            image: nil,
            weight: weight,
            isAddPetPlaceholder: false,
            allPetsPlaceholder: false,
            isSelected: false
        )
    }
}

// MARK: - Sample Data
extension PetModel {
    static var samplePets: [PetModel] = [
        makeSamplePet(
            name: "Rex",
            species: "Cachorro",
            breed: "Vira-lata",
            size: "Médio",
            gender: "Macho",
            isCastrated: true,
            dateOfBirth: "01/01/2020",
            weight: 5.00
        ),
        makeSamplePet(
            name: "Mimi",
            species: "Gato",
            breed: "Siamês",
            size: "Pequeno",
            gender: "Fêmea",
            isCastrated: false,
            dateOfBirth: "15/05/2019",
            weight: 3.50
        ),
        makeSamplePet(
            name: "Luna",
            species: "Cachorro",
            breed: "Labrador",
            size: "Grande",
            gender: "Fêmea",
            isCastrated: true,
            dateOfBirth: "10/10/2018",
            weight: 25.00
        ),
        makeSamplePet(
            name: "Thor",
            species: "Cachorro",
            breed: "Husky Siberiano",
            size: "Grande",
            gender: "Macho",
            isCastrated: false,
            dateOfBirth: "05/07/2017",
            weight: 22.50
        ),
        makeSamplePet(
            name: "Bella",
            species: "Cachorro",
            breed: "Golden Retriever",
            size: "Grande",
            gender: "Fêmea",
            isCastrated: true,
            dateOfBirth: "20/03/2019",
            weight: 28.00
        ),
        makeSamplePet(
            name: "Oliver",
            species: "Gato",
            breed: "Persa",
            size: "Pequeno",
            gender: "Macho",
            isCastrated: true,
            dateOfBirth: "12/12/2020",
            weight: 4.20
        ),
        makeSamplePet(
            name: "Mel",
            species: "Cachorro",
            breed: "Poodle",
            size: "Pequeno",
            gender: "Fêmea",
            isCastrated: true,
            dateOfBirth: "08/09/2021",
            weight: 6.80
        ),
        makeSamplePet(
            name: "Simba",
            species: "Gato",
            breed: "Maine Coon",
            size: "Grande",
            gender: "Macho",
            isCastrated: false,
            dateOfBirth: "03/04/2018",
            weight: 8.50
        )
    ]
    
    static var samplePetImages: [Image] = [
        Image(asset: .pet01),
        Image(asset: .pet02),
        Image(asset: .pet03),
        Image(asset: .pet04),
        Image(asset: .pet05),
        Image(asset: .pet06)
    ]
}
