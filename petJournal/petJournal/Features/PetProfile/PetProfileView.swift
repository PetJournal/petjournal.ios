import SwiftUI

struct PetProfileView: View {
    // MARK: - Properties
    @EnvironmentObject var router: NavigationRouter
    @StateObject private var viewModel: PetProfileViewModel
    let pet: PetModel
    
    // MARK: - Initialization
    init(pet: PetModel) {
        self.pet = pet
        self._viewModel = StateObject(wrappedValue: PetProfileViewModel(petId: pet.id))
    }
    
    // MARK: - Body
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                headerSection
                servicesSection
                tasksContentSection
                Spacer()
            }
            .padding()
            .task { await viewModel.loadTasks() }
        }
    }
}

// MARK: - Main Sections
private extension PetProfileView {
    var headerSection: some View {
        HStack(alignment: .top, spacing: 16) {
            petImageSection
            petInfoSection
        }
    }
    
    var servicesSection: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(TagModel.mockServices) { service in
                    ServiceTagItemView(tag: service)
                }
            }
        }
    }
    
    var tasksContentSection: some View {
        Group {
            if viewModel.isLoading {
                loadingView
            } else if let errorMessage = viewModel.errorMessage {
                errorView(errorMessage)
            } else {
                tasksSection
            }
        }
    }
}

// MARK: - Pet Header Components
private extension PetProfileView {
    var petImageSection: some View {
        ZStack {
            petImageContent
            imageBorder
        }
    }
    
    var petImageContent: some View {
        Group {
            if let petImage = pet.petImage {
                petImage
                    .resizable()
            } else {
                Image(.icPawFilled)
                    .resizable()
                    .foregroundColor(.theme.petGray300)
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .aspectRatio(1, contentMode: .fit)
    }
    
    var imageBorder: some View {
        RoundedRectangle(cornerRadius: 16)
            .stroke(Color.theme.petGray300, lineWidth: 2)
    }
    
    var petInfoSection: some View {
        ZStack {
            infoBackground
            infoContent
            editButton
        }
        .aspectRatio(1, contentMode: .fit)
    }
    
    var infoBackground: some View {
        RoundedRectangle(cornerRadius: 12)
            .fill(Color.theme.petPrimaryBackground)
    }
    
    var infoContent: some View {
        VStack(alignment: .leading, spacing: 8) {
            petNameText
            specieGenderText
            breedText
            ageSizeText
        }
        .foregroundColor(Color.theme.petPrimary500)
        .padding()
    }
    
    var editButton: some View {
        Button(action: { router.navigate(to: .petRegister(pet: pet)) }) {
            Image(.icEdit)
        }
        .offset(x: 50, y: -50)
    }
}

// MARK: - Pet Info Text Components
private extension PetProfileView {
    var petNameText: some View {
        Text(pet.petName)
            .font(.robotoSemiBold(size: .biggest))
            .lineLimit(1)
    }
    
    var specieGenderText: some View {
        HStack {
            Text(pet.specie.name)
            Text(".")
            Text(pet.gender)
        }
        .font(.robotoSemiBold(size: .medium))
    }
    
    var breedText: some View {
        Text(pet.breedAlias ?? "")
            .font(.robotoSemiBold(size: .medium))
    }
    
    var ageSizeText: some View {
        HStack {
            Text(pet.dateOfBirth.calculateAge())
            Text(".")
            Text(pet.size.name)
        }
        .font(.robotoSemiBold(size: .medium))
    }
}

// MARK: - Tasks Components
private extension PetProfileView {
    var tasksSection: some View {
        VStack(spacing: 16) {
            upcomingTasksSection
            historicTasksSection
        }
    }
    
    var upcomingTasksSection: some View {
        VStack(spacing: 16) {
            sectionTitle("Próximas tarefas:")
            upcomingTasksList
        }
    }
    
    var historicTasksSection: some View {
        VStack(spacing: 16) {
            sectionTitle("Histórico do pet")
            historicTasksList
        }
    }
    
    var upcomingTasksList: some View {
        Group {
            if viewModel.upcomingTasks.isEmpty {
                emptyTasksView
            } else {
                ForEach(Array(viewModel.upcomingTasks.enumerated()), id: \.offset) { index, task in
                    Text(task)
                        .padding()
                        .background(Color.theme.petPrimaryBackground)
                        .cornerRadius(8)
                }
            }
        }
    }
    
    var historicTasksList: some View {
        Group {
            if viewModel.historicTasks.isEmpty {
                emptyTasksView
            } else {
                ForEach(Array(viewModel.historicTasks.enumerated()), id: \.offset) { index, task in
                    Text(task)
                        .padding()
                        .background(Color.theme.petGray300)
                        .cornerRadius(8)
                }
            }
        }
    }
}

// MARK: - State Views
private extension PetProfileView {
    var loadingView: some View {
        ProgressView("Carregando tarefas...")
            .padding()
    }
    
    func errorView(_ message: String) -> some View {
        Text("Erro: \(message)")
            .foregroundColor(.red)
            .padding()
    }
    
    var emptyTasksView: some View {
        Text("Nenhuma tarefa encontrada")
            .foregroundColor(.gray)
            .padding()
    }
}

// MARK: - Helper Views
private extension PetProfileView {
    func sectionTitle(_ title: String) -> some View {
        Text(title)
            .font(.robotoMedium(size: .large))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal)
    }
}

// MARK: - Preview
struct PetProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PetProfileView(pet: PetModel.preview)
        }
        .environmentObject(NavigationRouter())
        .previewDisplayName("Perfil do Pet")
    }
}
