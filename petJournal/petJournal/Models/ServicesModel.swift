import SwiftUI

struct ServiceModel: Identifiable, Hashable {
    var id: Int
    var name: String
    var image: String
    let color: Color
    var backgroundColor: Color
    
    init(id: Int, name: String,
         image: String, color: Color,
         backgroundColor: Color = .theme.petWhite) {
        self.id = id
        self.name = name
        self.image = image
        self.color = color
        self.backgroundColor = backgroundColor
    }
    
    static var mockServices = [
        ServiceModel(id: 0, name: "Todos",
                     image: ImageAsset.all.rawValue,
                     color: .theme.petWhite,
                     backgroundColor: .theme.petPrimary500),
        ServiceModel(id: 1, name: "Vacinas",
                     image: ImageAsset.vaccine.rawValue,
                     color: Color.theme.petOrange),
        ServiceModel(id: 2, name: "Consultas",
                     image: ImageAsset.vetAppointment.rawValue,
                     color: Color.theme.petGreen),
        ServiceModel(id: 3, name: "Ração",
                     image: ImageAsset.dogFood.rawValue,
                     color: Color.theme.petPrimary500),
        ServiceModel(id: 4, name: "Medicamento",
                     image: ImageAsset.medicine.rawValue,
                     color: Color.theme.petWarning500),
        ServiceModel(id: 5, name: "Banhos",
                     image: ImageAsset.shower.rawValue,
                     color: Color.theme.petSecondary500),
        ServiceModel(id: 6, name: "Passeio",
                     image: ImageAsset.dogFace.rawValue,
                     color: Color.theme.petWarning100)
    ]
}
