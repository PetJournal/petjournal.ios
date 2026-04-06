import SwiftUI

//MARK: - Button Types
enum PetButtonType: Equatable {
    case pet(PetModel?)
    case allPets(isSelected: Bool = false)
    case addPet
    
    var displayName: String {
        switch self {
        case .pet(let pet):
            return pet?.petName ?? ""
        case .allPets:
            return "Todos"
        case .addPet:
            return "Adicionar"
        }
    }
    
    var image: Image {
        switch self {
        case .pet(let pet):
            if let petImage = pet?.computedPetImage {
                return petImage
            } else {
                return Image(.icPawFilled)
//                Usar imagem padrão quando não há imagem do pet
            }
        case .allPets(let isSelected):
            return isSelected ? Image(.icAllPets) : Image(.icPawFilled)
        case .addPet:
            return Image(.icPlus)
        }
    }
    
    var isSelectable: Bool {
        switch self {
        case .pet, .allPets:
            return true
        case .addPet:
            return false
        }
    }
}

//MARK: - Main Component
struct PetButton: View {
    let type: PetButtonType
    var isBordered: Bool = false
    var isSelected: Bool = false
    var frameSize: CGFloat = 100
    let action: () -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            mainContent()
            titleContent()
        }
        .onTapGesture(perform: action)
        .accessibilityIdentifier("petButton_\(type.displayName)")
    }
}

//MARK: - Private Functions
extension PetButton {
    private func titleContent() -> some View {
        Text(type.displayName)
            .font(.robotoLight(size: .medium))
            .foregroundColor(Color.theme.petBlack)
    }
    
    private func imageContent() -> some View {
        type.image
            .resizable()
            .scaledToFill()
            .frame(width: frameSize, height: frameSize)
            .cornerRadius(12)
            .foregroundColor((type == .allPets(isSelected: false)) ? .theme.petPrimary500 : .theme.petGray300)
    }
    
    private func mainContent() -> some View {
        ZStack {
            imageContent()
            createOverlayContent(isBordered: isBordered,
                                 isSelected: isSelected && type.isSelectable)
        }
        .frame(width: frameSize, height: frameSize)
    }
    
    private func createBorder(isBordered: Bool) -> some View {
        RoundedRectangle(cornerRadius: 12)
            .stroke(checkBorder() ? Color.theme.petPrimary500 : Color.theme.petGray300, lineWidth: 2)
    }
    
    private func checkBorder() -> Bool {
        return isBordered || type == .allPets(isSelected: false)
    }

    private func createSelectionIcon(isSelected: Bool) -> some View {
        Group {
            if isSelected {
                Image(.icPawFilled)
                    .resizable()
                    .foregroundColor(.theme.petPrimary500)
            }
        }
    }

    private func createOverlayContent(isBordered: Bool, isSelected: Bool) -> some View {
        ZStack {
            createBorder(isBordered: isBordered)
            createSelectionIcon(isSelected: isSelected)
        }
    }
}

//MARK: - Preview
struct PetButton_Previews: PreviewProvider {
    static let gridColumns = Array(repeating: GridItem(.flexible()),
                                   count: 3)
    
    static var previews: some View {
        ScrollView {
            LazyVGrid(columns: gridColumns, spacing: 20) {
                Text("Botões sem borda")
                    .font(.robotoMedium(size: .small))
                PetButton(
                    type: .pet(PetModel.preview),
                    isSelected: true, action: {}
                )
                PetButton(
                    type: .pet(PetModel.preview),
                    isSelected: false, action: {}
                )
                
                Text("Botões com borda")
                    .font(.robotoMedium(size: .small))
                PetButton(
                    type: .pet(PetModel.preview),
                    isBordered: true, isSelected: false,
                    action: {}
                )
                PetButton(
                    type: .pet(PetModel.preview),
                    isBordered: true, isSelected: true,
                    action: {}
                )
                Text("")
                Text("Botões de ação")
                    .font(.robotoMedium(size: .small))
                Text("")
                PetButton(
                    type: .addPet, action: {}
                )
                PetButton(
                    type: .allPets(isSelected: true),
                    action: {}
                )
                PetButton(
                    type: .allPets(isSelected: false),
                    action: {}
                )
            }
            .padding()
        }.previewDisplayName("Variações de uso")
    }
}
