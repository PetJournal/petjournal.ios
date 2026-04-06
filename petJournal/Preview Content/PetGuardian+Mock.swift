import Foundation

// MARK: - PetGuardian Mock Data
extension PetGuardian {
    static let mockGuardian = PetGuardian(
        id: "guardian-1",
        firstName: "João",
        lastName: "Silva",
        email: "joao.silva@email.com",
        phone: "+55 11 99999-9999",
        image: nil
    )
    
    static let mockGuardians = [
        mockGuardian,
        PetGuardian(
            id: "guardian-2",
            firstName: "Maria",
            lastName: "Santos",
            email: "maria.santos@email.com",
            phone: "+55 11 88888-8888",
            image: nil
        ),
        PetGuardian(
            id: "guardian-3",
            firstName: "Pedro",
            lastName: "Costa",
            email: "pedro.costa@email.com",
            phone: "+55 11 77777-7777",
            image: nil
        )
    ]
    
    // Preview helpers
    static var preview: PetGuardian {
        mockGuardian
    }
    
    static var previewList: [PetGuardian] {
        mockGuardians
    }
}
