import SwiftUI

struct PetTaskModel: Identifiable {
    let id = UUID()
    let title: String
    let schedule: String
    let description: String
    let petImages: [Image]
    let accentColor: Color
    let backgroundIcon: Image
    var taskType: TaskType = .all
    var startAt: String
    var isPast: Bool
    
    init(title: String, schedule: String, 
         description: String, petImages: [Image],
         accentColor: Color, backgroundIcon: Image,
         taskType: TaskType, startAt: String = "2026-05-04T13:00:00Z") {
        self.title = title
        self.schedule = schedule
        self.description = description
        self.petImages = petImages
        self.accentColor = accentColor
        self.backgroundIcon = backgroundIcon
        self.taskType = taskType
        self.startAt = startAt
        self.isPast = startAt.isDateInThePast()
    }
    
    static var sampleTasks = [
        PetTaskModel(
            title: "Carprofeno",
            schedule: "Manhã e noite",
            description: "Anti-inflamatório não esteroide para alívio da dor e inflamação.\n\nAqui tem mais informação para ser lida camarada! Você pode ser até uma informação bem detalhada com todo cuidado que seu Pet merece <3",
            petImages: PetModel.samplePetImages,
            accentColor: Color.theme.petSecondary500,
            backgroundIcon: Image(asset: .medicine), 
            taskType: .medicine, startAt: "2025-12-04T13:00:00Z"
        ),
        PetTaskModel(
            title: "Consulta médica",
            schedule: "15/06 às 14:00",
            description: "Check-up anual\n\nAqui tem mais informação para ser lida camarada! Você pode ser até uma informação bem detalhada com todo cuidado que seu Pet merece <3",
            petImages: PetModel.samplePetImages,
            accentColor: Color.theme.petGreen,
            backgroundIcon: Image(asset: .vetAppointment),
            taskType: .consultation, startAt: "2025-11-04T12:00:00Z"
        ),
        PetTaskModel(
            title: "Vacina Antirrábica",
            schedule: "15/06 às 14:00",
            description: "Dose anual da vacina antirrábica",
            petImages: PetModel.samplePetImages,
            accentColor: Color.theme.petOrange,
            backgroundIcon: Image(asset: .vaccine),
            taskType: .vaccine, startAt: "2025-10-12T09:00:00Z"
        )
    ]
    
    static var sampleHistoricTasks = [
        PetTaskModel(
            title: "Carprofeno",
            schedule: "Manhã e noite",
            description: "Anti-inflamatório não esteroide para alívio da dor e inflamação.\n\nAqui tem mais informação para ser lida camarada! Você pode ser até uma informação bem detalhada com todo cuidado que seu Pet merece <3",
            petImages: PetModel.samplePetImages,
            accentColor: Color.theme.petPrimary100,
            backgroundIcon: Image(asset: .medicine), 
            taskType: .medicine, startAt: "2024-03-04T15:00:00Z"
        ),
        PetTaskModel(
            title: "Consulta médica",
            schedule: "15/06 às 14:00",
            description: "Check-up anual\n\nAqui tem mais informação para ser lida camarada! Você pode ser até uma informação bem detalhada com todo cuidado que seu Pet merece <3",
            petImages: PetModel.samplePetImages,
            accentColor: Color.theme.petPrimary100,
            backgroundIcon: Image(asset: .vetAppointment),
            taskType: .consultation, startAt: "2024-02-04T16:00:00Z"
        )
    ]
}
