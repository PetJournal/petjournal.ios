import Foundation
import SwiftUI

// MARK: - Main Models
struct PetModel: Identifiable, Hashable, Codable {
    let id: String
    let guardian: Guardian?
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
    let weight: Double?
    var isAddPetPlaceholder: Bool = false
    var allPetsPlaceholder: Bool = false
    var isSelected: Bool = false
    
    // Computed property for easier image handling
    var petImage: PetImage {
        if isAddPetPlaceholder {
            return .image(Image(asset: .addSignal))
        }
        if allPetsPlaceholder {
            return .image(Image(asset: isSelected ? .petSelected : .petUnselected))
        }
        if let imageData = self.image, let uiImage = UIImage(data: imageData) {
            return .image(Image(uiImage: uiImage))
        }
        if image == nil {
            return .image(PetModel.samplePetImages.randomElement()!)
        }
        return .placeholder
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
            return Image(asset: .paw)
        }
    }
}

// MARK: - Factory Methods & Sample Data
extension PetModel {
    static func makePlaceholder(type: PlaceholderType,
                                isSelected: Bool = false) -> PetModel {
        return PetModel(
            id: UUID().uuidString,
            guardian: nil,
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
        weight: Double
    ) -> PetModel {
        return PetModel(
            id: UUID().uuidString,
            guardian: nil,
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
            weight: weight
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
