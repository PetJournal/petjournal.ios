import SwiftUI

struct ServiceModel: Identifiable {
    var id: Int
    var name: String
    var image: Image
    let color: Color
    var backgroundColor: Color
    
    init(id: Int, name: String,
         image: Image, color: Color,
         backgroundColor: Color = .theme.petWhite) {
        self.id = id
        self.name = name
        self.image = image
        self.color = color
        self.backgroundColor = backgroundColor
    }
}

extension ServiceModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: ServiceModel, rhs: ServiceModel) -> Bool {
        lhs.id == rhs.id
    }
    
    static var mockServices = [
        ServiceModel(id: 0, name: "Todos",
                     image: Image(.icAll),
                     color: .theme.petWhite,
                     backgroundColor: .theme.petPrimary500),
        ServiceModel(id: 1, name: "Vacinas",
                     image: Image(.icVaccine),
                     color: Color.theme.petOrange),
        ServiceModel(id: 2, name: "Consultas",
                     image: Image(.icVetAppointment),
                     color: Color.theme.petGreen),
        ServiceModel(id: 3, name: "Ração",
                     image: Image(.icDogFood),
                     color: Color.theme.petPrimary500),
        ServiceModel(id: 4, name: "Medicamento",
                     image: Image(.icMedicine),
                     color: Color.theme.petWarning500),
        ServiceModel(id: 5, name: "Banhos",
                     image: Image(.icShower),
                     color: Color.theme.petSecondary500),
        ServiceModel(id: 6, name: "Passeio",
                     image: Image(.icDogFace),
                     color: Color.theme.petWarning100)
    ]
}
