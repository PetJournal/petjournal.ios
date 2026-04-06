import SwiftUI

// MARK: - Supporting Models Mock Data
extension Species {
    static let mockDogSpecies = Species(id: "species-1", name: "Cachorro")
    static let mockCatSpecies = Species(id: "species-2", name: "Gato")
    
    static var preview: Species { mockDogSpecies }
}

extension Breed {
    static let mockBreeds = [
        Breed(id: "breed-1", name: "Poodle"),
        Breed(id: "breed-2", name: "Labrador"),
        Breed(id: "breed-3", name: "Siamês"),
        Breed(id: "breed-4", name: "Persa"),
        Breed(id: "breed-5", name: "Golden Retriever"),
        Breed(id: "breed-6", name: "Maine Coon")
    ]
    
    static var preview: Breed { mockBreeds[0] }
    static var previewList: [Breed] { mockBreeds }
}

extension PetSize {
    static let mockSizes = [
        PetSize(id: "size-1", name: "Pequeno (Até 10kg)"),
        PetSize(id: "size-2", name: "Médio (11 à 24Kg)"),
        PetSize(id: "size-3", name: "Grande (25 à 45Kg)")
    ]
    
    static var preview: PetSize { mockSizes[0] }
    static var previewList: [PetSize] { mockSizes }
}

// MARK: - PetModel Mock Data
extension PetModel {
    static let mockPets = [
        PetModel(
            id: "pet-1",
            guardian: PetGuardian.mockGuardian,
            specie: Species.mockDogSpecies,
            specieAlias: nil,
            petName: "Rex",
            gender: "M",
            breed: Breed.mockBreeds[0],
            breedAlias: nil,
            size: PetSize.mockSizes[1],
            castrated: false,
            dateOfBirth: "2020-01-01"
        ),
        PetModel(
            id: "pet-2",
            guardian: PetGuardian.mockGuardian,
            specie: Species.mockCatSpecies,
            specieAlias: nil,
            petName: "Mimi",
            gender: "F",
            breed: Breed.mockBreeds[2],
            breedAlias: nil,
            size: PetSize.mockSizes[0],
            castrated: true,
            dateOfBirth: "2019-05-15"
        ),
        PetModel(
            id: "pet-3",
            guardian: PetGuardian.mockGuardian,
            specie: Species.mockDogSpecies,
            specieAlias: nil,
            petName: "Luna",
            gender: "F",
            breed: Breed.mockBreeds[1],
            breedAlias: nil,
            size: PetSize.mockSizes[2],
            castrated: true,
            dateOfBirth: "2018-10-10"
        ),
        PetModel(
            id: "pet-4",
            guardian: PetGuardian.mockGuardian,
            specie: Species.mockDogSpecies,
            specieAlias: nil,
            petName: "Thor",
            gender: "M",
            breed: Breed.mockBreeds[4],
            breedAlias: nil,
            size: PetSize.mockSizes[2],
            castrated: false,
            dateOfBirth: "2017-07-05"
        ),
        PetModel(
            id: "pet-5",
            guardian: PetGuardian.mockGuardian,
            specie: Species.mockCatSpecies,
            specieAlias: nil,
            petName: "Oliver",
            gender: "M",
            breed: Breed.mockBreeds[5],
            breedAlias: nil,
            size: PetSize.mockSizes[0],
            castrated: true,
            dateOfBirth: "2020-12-12"
        )
    ]
    
    // Preview helpers
    static var preview: PetModel {
        mockPets[0]
    }
    
    static var previewList: [PetModel] {
        mockPets
    }
    
    static var previewDogs: [PetModel] {
        mockPets.filter { $0.specie.name == "Cachorro" }
    }
    
    static var previewCats: [PetModel] {
        mockPets.filter { $0.specie.name == "Gato" }
    }
}
