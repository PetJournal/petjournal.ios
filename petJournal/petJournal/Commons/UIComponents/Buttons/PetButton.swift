import SwiftUI

struct PetButton: View {
    let pet: PetModel
    let action: () -> Void
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            pet.petImage.image
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .cornerRadius(16)
                .clipped()
            
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
                ForEach(PetModel.samplePets) { pet in
                    PetButton(
                        pet: pet,
                        action: {}
                    )
                }
                
                PetButton(
                    pet: PetModel.makePlaceholder(type: .addPet),
                    action: {}
                )
            }
            .padding()
        }
    }
}
