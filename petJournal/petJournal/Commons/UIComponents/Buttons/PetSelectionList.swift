import SwiftUI

struct PetSelectionList: View {
    // MARK: - Properties
    let pets: [PetModel]
    let allowsMultipleSelection: Bool
    let showSelectAllButton: Bool
    @Binding var selectedPets: [PetModel]
    
    // MARK: - Computed Properties
    private var allPetsSelected: Bool {
        !pets.isEmpty && selectedPets.count == pets.count
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            petsHorizontalScrollView
        }
    }
    
    // MARK: - Subviews
    private var petsHorizontalScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                selectAllButtonIfNeeded
                petButtonsList
            }
        }
    }
    
    @ViewBuilder
    private var selectAllButtonIfNeeded: some View {
        if shouldShowSelectAllButton {
            selectAllButton
        }
    }
    
    private var selectAllButton: some View {
        PetButtonWrapper(
            pet: .makePlaceholder(type: .allPets, isSelected: allPetsSelected),
            action: toggleAllPets
        )
    }
    
    private var petButtonsList: some View {
        ForEach(pets) { pet in
            petButton(for: pet)
        }
    }
    
    private func petButton(for pet: PetModel) -> some View {
        PetButtonWrapper(
            pet: pet,
            isSelected: isPetSelected(pet),
            isBordered: true,
            action: { toggleSelection(for: pet) }
        )
    }
    
    // MARK: - Helper Properties
    private var shouldShowSelectAllButton: Bool {
        showSelectAllButton && allowsMultipleSelection
    }
    
    // MARK: - Selection Logic
    private func isPetSelected(_ pet: PetModel) -> Bool {
        selectedPets.contains { $0.id == pet.id }
    }
    
    private func toggleSelection(for pet: PetModel) {
        if allowsMultipleSelection {
            toggleMultiSelection(for: pet)
        } else {
            selectedPets = [pet]
        }
    }
    
    private func toggleMultiSelection(for pet: PetModel) {
        if let index = selectedPets.firstIndex(where: { $0.id == pet.id }) {
            selectedPets.remove(at: index)
        } else {
            selectedPets.append(pet)
        }
    }
    
    private func toggleAllPets() {
        selectedPets = allPetsSelected ? [] : pets
    }
}

// MARK: - Button Wrapper
struct PetButtonWrapper: View {
    let pet: PetModel
    var isSelected: Bool = false
    var isBordered: Bool = false
    let action: () -> Void
    
    var body: some View {
        PetButton(
            pet: pet,
            isBordered: isBordered,
            isSelected: isSelected,
            action: action
        )
        .padding(2)
    }
}

// MARK: - Preview
struct PetSelectionList_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        let samplePets = PetModel.samplePets
        @State var selectedPets: [PetModel] = []
        
        var body: some View {
            VStack() {
                PetSelectionList(
                    pets: samplePets,
                    allowsMultipleSelection: true,
                    showSelectAllButton: true,
                    selectedPets: $selectedPets
                )
                selectedPetsPreview
            }.padding()

        }
        
        private var selectedPetsPreview: some View {
            VStack {
                Text("Itens selecionados:")
                Spacer()
                VStack {
                    Text(selectedPets.map { $0.petName }.joined(separator: "\n"))
                        .font(.robotoSemiBold(size: .biggest))
                }
                Spacer()
            }
        }
    }
    
    static var previews: some View {
        PreviewWrapper()
            .previewDisplayName("Lista de pets para seleção")
    }
}
