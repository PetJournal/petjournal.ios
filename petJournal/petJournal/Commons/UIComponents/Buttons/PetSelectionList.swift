import SwiftUI

struct PetSelectionList: View {
    let pets: [PetModel]
    let allowsMultipleSelection: Bool
    let showSelectAllButton: Bool
    @Binding var selectedPets: [PetModel]
    
    private var allPetsSelected: Bool {
        !pets.isEmpty && selectedPets.count == pets.count
    }
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    if showSelectAllButton && allowsMultipleSelection {
                        PetButtonWrapper(
                            pet: PetModel.makePlaceholder(type: .allPets),
                            isSelected: allPetsSelected,
                            action: toggleAllPets
                        )
                    }
                    
                    ForEach(pets) { pet in
                        PetButtonWrapper(
                            pet: pet,
                            isSelected: isPetSelected(pet),
                            action: { toggleSelection(for: pet) }
                        )
                    }
                }
                .padding(.horizontal)
            }
        }
    }
    
    private func isPetSelected(_ pet: PetModel) -> Bool {
        selectedPets.contains { $0.id == pet.id }
    }
    
    private func toggleSelection(for pet: PetModel) {
        if allowsMultipleSelection {
            if let index = selectedPets.firstIndex(where: { $0.id == pet.id }) {
                selectedPets.remove(at: index)
            } else {
                selectedPets.append(pet)
            }
        } else {
            selectedPets = [pet]
        }
    }
    
    private func toggleAllPets() {
        if allPetsSelected {
            selectedPets = []
        } else {
            selectedPets = pets
        }
    }
}

struct PetButtonWrapper: View {
    let pet: PetModel
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        PetButton(pet: pet, isBordered: true, action: action)
            .padding(4)
            .background(isSelected ? Color.theme.petPrimary100 : .clear)
            .cornerRadius(16)
            .clipped()
            .animation(.easeInOut, value: isSelected)
    }
}

struct PetSelectionList_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        let samplePets = PetModel.samplePets
        @State var selectedPets: [PetModel] = []
        
        var body: some View {
            VStack(spacing: 20) {
                VStack {
                    PetSelectionList(
                        pets: samplePets,
                        allowsMultipleSelection: true,
                        showSelectAllButton: true,
                        selectedPets: $selectedPets
                    )
                    .frame(height: 150)
                    
                    VStack {
                        Text("Itens selecionados:")
                        Text(" \(selectedPets.map { $0.petName }.joined(separator: ", "))")
                            .font(.robotoMedium(size: .medium))
                    }                    
                }
            }
            .padding()
        }
    }
    
    static var previews: some View {
        PreviewWrapper()
            .previewDisplayName("Lista de pets para seleção")
    }
}
