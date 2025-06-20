import SwiftUI

struct PetButton: View {
    let pet: PetModel
    var isBordered: Bool = false
    var isSelected: Bool = false
    let action: () -> Void
    
    private func createBorder(isBordered: Bool) -> some View {
        RoundedRectangle(cornerRadius: 16)
            .stroke(isBordered ? Color.theme.petPrimary500 : .clear, lineWidth: 2)
    }

    private func createSelectionIcon(isSelected: Bool) -> some View {
        Group {
            if isSelected {
                Image(asset: .pawFill)
                    .resizable()
                    .frame(width: 45, height: 40)
            }
        }
    }

    private func createOverlayContent(isBordered: Bool, isSelected: Bool) -> some View {
        ZStack {
            createBorder(isBordered: isBordered)
            createSelectionIcon(isSelected: isSelected)
        }
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            pet.petImage.image
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .cornerRadius(16)
                .clipped()
                .overlay(
                    createOverlayContent(isBordered: isBordered, isSelected: isSelected)
                )
            
            Text(pet.petName)
                .font(.robotoLight(size: .medium))
                .foregroundColor(Color.theme.petBlack)
        }
        .onTapGesture(perform: action)
        .accessibilityIdentifier("petButton_\(pet.petName)")
    }
}

struct PetButton_Previews: PreviewProvider {
    static let gridColumns = Array(repeating: GridItem(.flexible()),
                                   count: 3)
    
    static var previews: some View {
        ScrollView {
            LazyVGrid(columns: gridColumns, spacing: 20) {
                Text("Botões sem borda")
                    .font(.robotoMedium(size: .small))
                PetButton(
                    pet: PetModel.samplePets[0],
                    isSelected: true,
                    action: {}
                )
                PetButton(
                    pet: PetModel.samplePets[0],
                    isSelected: false,
                    action: {}
                )
                
                Text("Botões com borda")
                    .font(.robotoMedium(size: .small))
                PetButton(
                    pet: PetModel.samplePets[0],
                    isBordered: true,
                    isSelected: false,
                    action: {}
                )
                PetButton(
                    pet: PetModel.samplePets[0],
                    isBordered: true,
                    isSelected: true,
                    action: {}
                )
                
                Text("Botões de ação")
                    .font(.robotoMedium(size: .small))
                PetButton(
                    pet: PetModel.makePlaceholder(type: .addPet),
                    action: {}
                )
                PetButton(
                    pet: PetModel.makePlaceholder(type: .allPets,
                                                  isSelected: true),
                    action: {}
                )
            }
            .padding()
        }.previewDisplayName("Variações de uso")
    }
}
