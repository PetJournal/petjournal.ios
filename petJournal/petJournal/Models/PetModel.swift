import Foundation
import SwiftUI

struct PetModel: Codable, Identifiable {
    var id = UUID()
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
    
    static var mockPets = [
        PetModel(specieName: "Cachorro", petName: "Rex", 
                 gender: "Macho", breedName: "Vira-lata",
                 size: "Médio", castrated: true,
                 dateOfBirth: "01/01/2020", image: nil),
        PetModel(specieName: "Gato", petName: "Mimi",
                 gender: "Fêmea", breedName: "Siamês",
                 size: "Pequeno", castrated: false,
                 dateOfBirth: "15/05/2019", image: nil),
        PetModel(specieName: "Cachorro", petName: "Luna",
                 gender: "Fêmea", breedName: "Labrador",
                 size: "Grande", castrated: true,
                 dateOfBirth: "10/10/2018", image: nil)
    ]
    
    static var mockPetImages = [
        Image.init(asset: .banner01),
        Image.init(asset: .logoBlue),
        Image.init(asset: .banner02),
        Image.init(asset: .logoPrimary),
        Image.init(asset: .banner03)
    ]
    
    func getImage() -> Image {
        if let image = self.image, let image = UIImage(data: image) {
            return Image(uiImage: image)
        } else {
            return PetModel.mockPetImages.randomElement()!
        }
    }
}
