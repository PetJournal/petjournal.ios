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
    
    init(
        id: String, guardianId: String? = nil,
        specie: Species, specieAlias: String? = nil,
        petName: String, gender: String,
        breed: Breed, breedAlias: String? = nil,
        size: PetSize, castrated: Bool,
        dateOfBirth: String, image: Data? = nil
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
    }

    var petImage: Image? {
        if let imageString = self.image, !imageString.isEmpty,
           let imageData = Data(base64Encoded: imageString),
           let uiImage = UIImage(data: imageData) {
            return Image(uiImage: uiImage)
        } else {
            return nil
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

// MARK: - Factory Method
extension PetModel {
    static func makeSamplePet(
        name: String, species: String,
        breed: String, size: String,
        gender: String, isCastrated: Bool,
        dateOfBirth: String
    ) -> PetModel {
        return PetModel(
            id: UUID().uuidString, guardianId: nil,
            specie: Species(id: UUID().uuidString, name: species),
            specieAlias: nil, petName: name, gender: gender,
            breed: Breed(id: UUID().uuidString, name: breed),
            breedAlias: nil, size: PetSize(id: UUID().uuidString, name: size),
            castrated: isCastrated, dateOfBirth: dateOfBirth, image: nil
        )
    }
}

// MARK: - Sample Data
extension PetModel {
    static var samplePets: [PetModel] = [
        makeSamplePet(
            name: "Rex", species: "Cachorro",
            breed: "Vira-lata", size: "Médio",
            gender: "Macho",  isCastrated: true,
            dateOfBirth: "01/01/2020"
        ),
        makeSamplePet(
            name: "Mimi", species: "Gato",
            breed: "Siamês", size: "Pequeno",
            gender: "Fêmea", isCastrated: false,
            dateOfBirth: "15/05/2019"
        ),
        makeSamplePet(
            name: "Luna", species: "Cachorro",
            breed: "Labrador", size: "Grande",
            gender: "Fêmea", isCastrated: true,
            dateOfBirth: "10/10/2018"
        ),
        makeSamplePet(
            name: "Thor", species: "Cachorro",
            breed: "Husky Siberiano", size: "Grande",
            gender: "Macho", isCastrated: false,
            dateOfBirth: "05/07/2017"
        ),
        makeSamplePet(
            name: "Bella", species: "Cachorro",
            breed: "Golden Retriever", size: "Grande",
            gender: "Fêmea", isCastrated: true,
            dateOfBirth: "20/03/2019"
        ),
        makeSamplePet(
            name: "Oliver", species: "Gato",
            breed: "Persa", size: "Pequeno",
            gender: "Macho", isCastrated: true,
            dateOfBirth: "12/12/2020"
        ),
        makeSamplePet(
            name: "Mel", species: "Cachorro",
            breed: "Poodle", size: "Pequeno",
            gender: "Fêmea", isCastrated: true,
            dateOfBirth: "08/09/2021"
        ),
        makeSamplePet(
            name: "Simba", species: "Gato",
            breed: "Maine Coon", size: "Grande",
            gender: "Macho", isCastrated: false,
            dateOfBirth: "03/04/2018"
        )
    ]
    
    static var samplePetImages: [Image] = [
        Image(.pet1), Image(.pet2),
        Image(.pet3), Image(.pet4),
        Image(.pet5), Image(.pet6)
    ]
}
