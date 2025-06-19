import SwiftUI

protocol PetProfileCoordinatorProtocol {
    func navigateToEditPet(pet: PetModel)
}

struct PetProfileView: View {
    let pet: PetModel
    let coordinator: PetProfileCoordinatorProtocol
    
    var body: some View {
        VStack(spacing: 16) {
            petHeaderView
            Spacer()
        }
        .padding()
    }
    
    private var petHeaderView: some View {
        HStack(alignment: .top, spacing: 16) {
            petImageView
            petInfoView
        }
    }
    
    private var petImageView: some View {
        pet.getImage()
            .resizable()
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .aspectRatio(1, contentMode: .fit)
    }
    
    private var petInfoView: some View {
        ZStack() {
            backgroundView
            petInfoContent
            editButton
                .offset(CGSize(width: 50, height: -50))
        }
        .aspectRatio(1, contentMode: .fit)
    }

    private var backgroundView: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.theme.petPrimaryBackground)
    }

    private var petInfoContent: some View {
        VStack(alignment: .leading, spacing: 8) {
            petNameView
            specieAndGenderView
            breedView
            ageAndWeightView
        }
        .foregroundColor(Color.theme.petPrimary500)
        .padding()
    }

    private var petNameView: some View {
        Text(pet.petName)
            .font(.robotoSemiBold(size: .biggest))
            .lineLimit(1)
    }

    private var specieAndGenderView: some View {
        HStack {
            Text(pet.specie.detail)
                .font(.robotoSemiBold(size: .medium))
            Text(".")
                .font(.robotoSemiBold(size: .medium))
            Text(pet.gender)
                .font(.robotoSemiBold(size: .medium))
        }
    }

    private var breedView: some View {
        HStack {
            Text(pet.breedAlias ?? "")
                .font(.robotoSemiBold(size: .medium))
        }
    }

    private var ageAndWeightView: some View {
        HStack {
            Text(ageText)
                .font(.robotoSemiBold(size: .medium))
            Text(".")
                .font(.robotoSemiBold(size: .medium))
            Text("\(pet.weight, specifier: "%.1f") kg")
                .font(.robotoSemiBold(size: .medium))
        }
    }

    private var editButton: some View {
        Button(action: {
            coordinator.navigateToEditPet(pet: pet)
        }) {
            Image(asset: .edit)
        }
    }
    
    private var ageText: String {
        calculateAge(from: pet.dateOfBirth)
    }
    
    private func calculateAge(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        guard let birthDate = dateFormatter.date(from: dateString) else {
            return "Idade desconhecida"
        }
        
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year, .month], from: birthDate, to: Date())
        
        if let years = ageComponents.year, years > 0 {
            return "\(years) ano\(years > 1 ? "s" : "")"
        } else if let months = ageComponents.month, months > 0 {
            return "\(months) mês\(months > 1 ? "es" : "")"
        } else {
            return "Recém-nascido"
        }
    }
}

// MARK: - Preview
struct PetProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let mockCoordinator = MockPetProfileCoordinator()
        
        return NavigationView {
            PetProfileView(
                pet: PetModel.mockPets.randomElement()!,
                coordinator: mockCoordinator
            )
        }.previewDisplayName("Inicio Perfil de Pet")
    }
}

class MockPetProfileCoordinator: PetProfileCoordinatorProtocol {
    func navigateToEditPet(pet: PetModel) {
        print("Navigate to edit pet: \(pet.petName)")
    }
}
