import SwiftUI

protocol PetProfileCoordinatorProtocol {
    func navigateToEditPet(pet: PetModel)
}

struct PetProfileView: View {
    let pet: PetModel
    let coordinator: PetProfileCoordinatorProtocol
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                petHeaderView
                servicesHorizontalScrollView
                petTasksView
                historicTasksView
                Spacer()
            }
            .padding()
        }
    }
    
    private var historicTasksView: some View {
        VStack(spacing: 16) {
            Text("Histórico do pet")                .font(.robotoMedium(size: .large))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            ForEach(PetTaskModel.sampleHistoricTasks) { task in
                PetTaskCard(presenter: PetTaskCardPresenter(task: task))
            }
        }
    }
    
    private var petTasksView: some View {
        VStack(spacing: 16) {
            Text("Próximas tarefas:")                .font(.robotoMedium(size: .large))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            ForEach(PetTaskModel.sampleTasks) { task in
                PetTaskCard(presenter: PetTaskCardPresenter(task: task))
            }
        }
    }
    
    private var servicesHorizontalScrollView: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack() {
                ForEach(ServiceModel.mockServices) { serv in
                    ServiceItemView(service: serv)
                }
            }
        }
    }
    
    private var petHeaderView: some View {
        HStack(alignment: .top, spacing: 16) {
            petImageView
            petInfoView
        }
    }
    
    private var petImageView: some View {
        pet.petImage.image
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
        pet.dateOfBirth.calculateAge()
    }
}

// MARK: - Preview
struct PetProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let mockCoordinator = MockPetProfileCoordinator()
        
        return NavigationView {
            PetProfileView(
                pet: PetModel.samplePets.randomElement()!,
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
