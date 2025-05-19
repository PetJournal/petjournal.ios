import Foundation
import SwiftUI

struct PetModel: Codable, Identifiable, Hashable {
    var id: String
    let guardianID: String?
    let specie: BreedDetail
    let specieAlias: String?
    let petName, gender: String
    let breedAlias: String?
    let breed, size: BreedDetail
    let castrated: Bool
    let dateOfBirth: String
    let image: Data?
    var addPet: Bool = false
    let weight: Double
    
    init(id: String = UUID().uuidString,
         guardianID: String, specieName: String,
         specieAlias: String, petName: String,
         gender: String, breedAlias: String, 
         breedName: String, size: String,
         castrated: Bool, dateOfBirth: String,
         image: Data?, addPet: Bool, weight: Double) {
        self.id = id
        self.guardianID = guardianID
        self.specie = BreedDetail(detail: specieName)
        self.specieAlias = specieAlias
        self.petName = petName
        self.gender = gender
        self.breed = BreedDetail(detail: breedName)
        self.breedAlias = breedAlias
        self.size = BreedDetail(detail: size)
        self.castrated = castrated
        self.dateOfBirth = dateOfBirth
        self.image = image
        self.addPet = addPet
        self.weight = weight
    }
}

extension PetModel {
    static var addPet: PetModel {
        PetModel(guardianID: "", specieName: "",
                 specieAlias: "", petName: "Adicionar",
                 gender: "", breedAlias: "",
                 breedName: "", size: "",
                 castrated: true, dateOfBirth: "",
                 image: nil, addPet: true, weight: 5.00)
    }
    //FIXME: Remove mocks
    static var mockPets = [
        PetModel(guardianID: "", specieName: "Cachorro",
                 specieAlias: "", petName: "Rex",
                 gender: "Macho", breedAlias: "",
                 breedName: "Vira-lata", size: "Médio",
                 castrated: true, dateOfBirth: "01/01/2020",
                 image: nil, addPet: false, weight: 5.00),
        PetModel(guardianID: "", specieName: "Gato",
                 specieAlias: "", petName: "Mimi",
                 gender: "Fêmea", breedAlias: "",
                 breedName: "Siamês", size: "Pequeno",
                 castrated: false, dateOfBirth: "15/05/2019",
                 image: nil, addPet: false, weight: 5.00),
        PetModel(guardianID: "", specieName: "Cachorro",
                 specieAlias: "", petName: "Luna",
                 gender: "Fêmea", breedAlias: "",
                 breedName: "Labrador", size: "Grande",
                 castrated: true, dateOfBirth: "10/10/2018",
                 image: nil, addPet: false, weight: 5.00)
    ]
    
    static var mockPetImages = [
        Image.init(asset: .pet01),
        Image.init(asset: .pet02),
        Image.init(asset: .pet03),
        Image.init(asset: .pet04),
        Image.init(asset: .pet05),
        Image.init(asset: .pet06)
    ]

    func getImage() -> Image {
        if !addPet, let image = self.image, let image = UIImage(data: image) {
            return Image(uiImage: image)
        } else if addPet {
            return Image.init(asset: .addSignal)
        } else {
            return PetModel.mockPetImages.randomElement()!
        }
    }
}

// MARK: - Breed Detail
struct BreedDetail: Codable, Identifiable, Hashable {
    var id: String
    let detail: String

    init(id: String = UUID().uuidString, detail: String) {
        self.id = id
        self.detail = detail
    }
}
