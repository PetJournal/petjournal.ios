import SwiftUI

// Estrutura para representar um pet
struct Pet: Identifiable {
    let id = UUID()
    let name: String
    let imageURL: String?
    let isAllPetsOption: Bool
}

// View para um item individual da lista
struct PetSelectItemView: View {
    let pet: Pet
    let isSelected: Bool
    
    var body: some View {
        VStack {
            // Container da imagem
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.white)
                    .shadow(radius: 2)
                    .frame(width: 80, height: 80)
                
                if pet.isAllPetsOption {
                    // Ícone de pata para opção "Todos"
                    Image(systemName: "pawprint.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 40, height: 40)
                        .foregroundColor(.purple)
                } else if let imageURL = pet.imageURL {
                    // Imagem do pet
                    AsyncImage(url: URL(string: imageURL)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(width: 80, height: 80)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(isSelected ? Color.purple : Color.clear, lineWidth: 2)
            )
            
            // Nome do pet
            Text(pet.name)
                .font(.subheadline)
                .foregroundColor(.black)
                .lineLimit(1)
        }
        .frame(width: 80)
    }
}

// View principal da lista de seleção
struct SelectPetList: View {
    @Binding var selectedPetId: UUID?
    let pets: [Pet]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 16) {
                ForEach(pets) { pet in
                    PetSelectItemView(
                        pet: pet,
                        isSelected: pet.id == selectedPetId
                    )
                    .onTapGesture {
                        selectedPetId = pet.id
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

// Preview para demonstração
#Preview {
    var samplePets = [
        Pet(name: "Todos", imageURL: nil, isAllPetsOption: true),
        Pet(name: "Jujuba", imageURL: nil, isAllPetsOption: false),
        Pet(name: "Alfredo", imageURL: nil, isAllPetsOption: false),
        Pet(name: "Alfredo", imageURL: nil, isAllPetsOption: false),
        Pet(name: "Alfredo", imageURL: nil, isAllPetsOption: false)
    ]
    
    SelectPetList(
        selectedPetId: .constant(samplePets[0].id),
        pets: samplePets
    )
}
