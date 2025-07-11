import SwiftUI

struct PetTaskModel: Identifiable {
    let id = UUID()
    let title: String
    let schedule: String
    let description: String
    let petImages: [Image]
    let accentColor: Color
    let backgroundIcon: Image
    
    init(title: String, schedule: String, 
         description: String, petImages: [Image],
         accentColor: Color, backgroundIcon: Image) {
        self.title = title
        self.schedule = schedule
        self.description = description
        self.petImages = petImages
        self.accentColor = accentColor
        self.backgroundIcon = backgroundIcon
    }
    
    static var sampleTasks = [
        PetTaskModel(
            title: "Carprofeno",
            schedule: "Manhã e noite",
            description: "Anti-inflamatório não esteroide para alívio da dor e inflamação.\n\nAqui tem mais informação para ser lida camarada! Você pode ser até uma informação bem detalhada com todo cuidado que seu Pet merece <3",
            petImages: PetModel.samplePetImages,
            accentColor: Color.theme.petSecondary500,
            backgroundIcon: Image(asset: .medicine)
        ),
        PetTaskModel(
            title: "Consulta médica",
            schedule: "15/06 às 14:00",
            description: "Check-up anual\n\nAqui tem mais informação para ser lida camarada! Você pode ser até uma informação bem detalhada com todo cuidado que seu Pet merece <3",
            petImages: PetModel.samplePetImages,
            accentColor: Color.theme.petCerise,
            backgroundIcon: Image(asset: .vetAppointment)
        )
    ]
    
    static var sampleHistoricTasks = [
        PetTaskModel(
            title: "Carprofeno",
            schedule: "Manhã e noite",
            description: "Anti-inflamatório não esteroide para alívio da dor e inflamação.\n\nAqui tem mais informação para ser lida camarada! Você pode ser até uma informação bem detalhada com todo cuidado que seu Pet merece <3",
            petImages: PetModel.samplePetImages,
            accentColor: Color.theme.petPrimary100,
            backgroundIcon: Image(asset: .medicine)
        ),
        PetTaskModel(
            title: "Consulta médica",
            schedule: "15/06 às 14:00",
            description: "Check-up anual\n\nAqui tem mais informação para ser lida camarada! Você pode ser até uma informação bem detalhada com todo cuidado que seu Pet merece <3",
            petImages: PetModel.samplePetImages,
            accentColor: Color.theme.petPrimary100,
            backgroundIcon: Image(asset: .vetAppointment)
        )
    ]
}
