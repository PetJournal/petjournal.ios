import Foundation

struct PetModel: Codable {
    let specieName: String
    let petName: String
    let gender: String
    let breedName: String
    let size: String
    let castrated: Bool
    let dateOfBirth: String
    let image: Data?
    
    init(specieName: String,
         petName: String,
         gender: String,
         breedName: String,
         size: String,
         castrated: Bool,
         dateOfBirth: String,
         image: Data?) {
        self.specieName = specieName
        self.petName = petName
        self.gender = gender
        self.breedName = breedName
        self.size = size
        self.castrated = castrated
        self.dateOfBirth = dateOfBirth
        self.image = image
    }
}

extension PetModel {
    static var newPet: PetModel {
        PetModel(specieName: "",
                 petName: "",
                 gender: "",
                 breedName: "",
                 size: "",
                 castrated: true,
                 dateOfBirth: "",
                 image: nil)
    }
}
