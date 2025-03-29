import SwiftUI

struct PetButton: View {
    let pet: PetModel
    var action: (() -> Void)
    
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            pet.getImage()
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .cornerRadius(16)
                .clipped()
            Text(pet.petName)
                .font(.robotoLight(size: .medium))
                .foregroundColor(Color.theme.petBlack)
        }
        .onTapGesture {
            action()
        }
    }
}

//MARK: - Preview
struct ContentView_Previews: PreviewProvider {
    static let columns = [
            GridItem(.flexible()),
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
    static var previews: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(PetModel.mockPets, id: \.self) { item in
                    PetButton(pet: item, action: {})
                }
                PetButton(pet: PetModel.addPet){}
            }
            .padding()
        }
    }
}
