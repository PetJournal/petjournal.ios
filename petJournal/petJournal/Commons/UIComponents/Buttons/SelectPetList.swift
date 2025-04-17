import SwiftUI

struct PetSelectItemView: View {
    let pet: PetModel
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)
                        .shadow(radius: 2)
                        .frame(width: 80, height: 80)
                    
                    pet.getImage()
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(isSelected ? Color.purple : Color.clear, lineWidth: 2)
                )
                
                Text(pet.petName)
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .lineLimit(1)
            }
            .frame(width: 80)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct AllPetsButton: View {
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 16)
                        .fill(Color.white)
                        .shadow(radius: 2)
                        .frame(width: 80, height: 80)
                    
                    Image(systemName: "pawprint.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.purple)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(isSelected ? Color.purple : Color.clear, lineWidth: 2)
                )
                
                Text("Todos")
                    .font(.subheadline)
                    .foregroundColor(.black)
                    .lineLimit(1)
            }
            .frame(width: 80)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

struct SelectPetList: View {
    @Binding var selectedPetId: String?
    let pets: [PetModel]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                AllPetsButton(
                    isSelected: selectedPetId == nil,
                    action: { print("Todos") }
                )
                
                ForEach(pets) { pet in
                    PetSelectItemView(
                        pet: pet,
                        isSelected: pet.id == selectedPetId,
                        action: { print(pet.petName) }
                    )
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    SelectPetList(
        selectedPetId: .constant(nil),
        pets: PetModel.mockPets
    )
}
