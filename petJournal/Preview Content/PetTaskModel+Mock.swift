import SwiftUI

// MARK: - PetTaskModel Mock Data
extension PetTaskModel {
    static let mockTasks = [
        PetTaskModel(
            id: "task-1",
            tagId: "tag-medicine",
            guardianId: "guardian-1",
            title: "Carprofeno",
            description: "Anti-inflamatório não esteroide para alívio da dor e inflamação.\n\nAdministrar conforme prescrição veterinária.",
            note: "Manhã e noite",
            startAt: "2025-01-20T08:00:00Z",
            endAt: "2025-01-20T20:00:00Z",
            daysOfWeek: [1, 2, 3, 4, 5, 6, 7],
            daysOfMonth: [],
            daily: true,
            pets: [PetModel.mockPets[0]]
        ),
        PetTaskModel(
            id: "task-2",
            tagId: "tag-consultation",
            guardianId: "guardian-1",
            title: "Consulta Veterinária",
            description: "Check-up anual de rotina.\n\nExames gerais e avaliação da saúde do pet.",
            note: "Levar carteira de vacinação",
            startAt: "2025-02-15T14:00:00Z",
            endAt: "2025-02-15T15:00:00Z",
            daysOfWeek: [],
            daysOfMonth: [15],
            daily: false,
            pets: [PetModel.mockPets[0], PetModel.mockPets[1]]
        ),
        PetTaskModel(
            id: "task-3",
            tagId: "tag-vaccine",
            guardianId: "guardian-1",
            title: "Vacina Antirrábica",
            description: "Dose anual da vacina antirrábica obrigatória.",
            note: "Jejum de 4 horas",
            startAt: "2025-03-10T09:00:00Z",
            endAt: "2025-03-10T10:00:00Z",
            daysOfWeek: [],
            daysOfMonth: [10],
            daily: false,
            pets: [PetModel.mockPets[2]]
        ),
        PetTaskModel(
            id: "task-4",
            tagId: "tag-medicine",
            guardianId: "guardian-1",
            title: "Vermífugo",
            description: "Administração de vermífugo para prevenção de parasitas.",
            note: "A cada 3 meses",
            startAt: "2025-04-01T10:00:00Z",
            endAt: "2025-04-01T11:00:00Z",
            daysOfWeek: [],
            daysOfMonth: [1],
            daily: false,
            pets: [PetModel.mockPets[3]]
        )
    ]
    
    static let mockHistoricTasks = [
        PetTaskModel(
            id: "task-historic-1",
            tagId: "tag-medicine",
            guardianId: "guardian-1",
            title: "Antibiótico",
            description: "Tratamento concluído com sucesso.",
            note: "Administrado por 7 dias",
            startAt: "2024-12-01T08:00:00Z",
            endAt: "2024-12-07T20:00:00Z",
            daysOfWeek: [1, 2, 3, 4, 5, 6, 7],
            daysOfMonth: [],
            daily: true,
            pets: [PetModel.mockPets[1]]
        ),
        PetTaskModel(
            id: "task-historic-2",
            tagId: "tag-vaccine",
            guardianId: "guardian-1",
            title: "Vacina V10",
            description: "Vacinação múltipla realizada.",
            note: "Próxima dose em 1 ano",
            startAt: "2024-11-20T10:00:00Z",
            endAt: "2024-11-20T11:00:00Z",
            daysOfWeek: [],
            daysOfMonth: [20],
            daily: false,
            pets: [PetModel.mockPets[0]]
        ),
        PetTaskModel(
            id: "task-historic-3",
            tagId: "tag-consultation",
            guardianId: "guardian-1",
            title: "Consulta de Emergência",
            description: "Atendimento de emergência realizado.",
            note: "Problema resolvido",
            startAt: "2024-10-15T16:00:00Z",
            endAt: "2024-10-15T17:30:00Z",
            daysOfWeek: [],
            daysOfMonth: [15],
            daily: false,
            pets: [PetModel.mockPets[2]]
        )
    ]
    
    // Preview helpers
    static var preview: PetTaskModel {
        mockTasks[0]
    }
    
    static var previewList: [PetTaskModel] {
        mockTasks
    }
    
    static var previewHistoric: [PetTaskModel] {
        mockHistoricTasks
    }
    
    static var previewMedicine: [PetTaskModel] {
        mockTasks.filter { $0.tagId.contains("medicine") }
    }
    
    static var previewConsultations: [PetTaskModel] {
        mockTasks.filter { $0.tagId.contains("consultation") }
    }
    
    static var previewVaccines: [PetTaskModel] {
        mockTasks.filter { $0.tagId.contains("vaccine") }
    }
}
