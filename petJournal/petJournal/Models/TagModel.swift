import SwiftUI

struct TagModel: Identifiable, Codable {
    var id: String
    var name: String
    var color: String
    
    // UI properties (not from API)
    var image: Image?
    var backgroundColor: Color?
    
    enum CodingKeys: String, CodingKey {
        case id, name, color
    }
    
    init(id: String, name: String, color: String, image: Image? = nil, backgroundColor: Color? = .theme.petWhite) {
        self.id = id
        self.name = name
        self.color = color
        self.image = image
        self.backgroundColor = backgroundColor
    }
    
    var colorValue: Color {
        Color(hex: color) ?? .theme.petPrimary500
    }
}

extension TagModel: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: TagModel, rhs: TagModel) -> Bool {
        lhs.id == rhs.id
    }
    
    static var mockServices = [
        TagModel(id: "1", name: "Vacinas", color: "#FF8C00", image: Image(.icVaccine)),
        TagModel(id: "2", name: "Consultas", color: "#32CD32", image: Image(.icVetAppointment)),
        TagModel(id: "3", name: "Ração", color: "#6A5ACD", image: Image(.icDogFood)),
        TagModel(id: "4", name: "Medicamento", color: "#FFD700", image: Image(.icMedicine)),
        TagModel(id: "5", name: "Banhos", color: "#FF69B4", image: Image(.icShower)),
        TagModel(id: "6", name: "Passeio", color: "#FFF8DC", image: Image(.icDogFace))
    ]
}

extension Color {
    init?(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            return nil
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
