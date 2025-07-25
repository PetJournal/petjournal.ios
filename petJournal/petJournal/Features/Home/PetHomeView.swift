import SwiftUI

// MARK: - Main View
struct PetHomeView: View {
    @StateObject private var viewModel = PetHomeViewModel()
    var pets: [PetModel]?
    var tasks: [PetTaskModel]?
    var services: [ServiceModel]?
    var banners: [HomeBanner]?
    
    var body: some View {
        ZStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    titleSection
                    bannersSection
                    petsSection
                    tasksSection
                    knowMoreSection
                    Spacer(minLength: 20)
                }
                .padding(.horizontal, 16)
            }
            .disabled(viewModel.isLoading)
            
            if viewModel.isLoading {
                LoadingView()
            }
        }
        .task {
            await viewModel.fetchUserData()
        }
    }
}

// MARK: - View Sections
private extension PetHomeView {
    // Title Section
    var titleSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Olá, \(viewModel.firstName) \(viewModel.lastName)!")
                    .font(.robotoLight(size: .large))
            }
            Spacer()
        }
        .padding(.top, 20)
    }
    
    // Banners Section
    var bannersSection: some View {
        Group {
            if let banners = banners, !banners.isEmpty {
                TabView {
                    ForEach(banners) { banner in
                        BannerView(banner: banner)
                            .padding(.horizontal, 4)
                            .cornerRadius(12)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 3)
                .frame(height: 180)
            }
        }
    }
    
    // Pets Section
    var petsSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text("Meus pets:")
                        .font(.robotoMedium(size: .big))
                    Spacer()
                    addPetButton
                }
                
                if let pets = pets, !pets.isEmpty {
                    petsScrollView(pets: pets)
                } else {
                    noPetsButton
                }
            }
            Spacer()
        }
    }
    
    // Tasks Section
    var tasksSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 20) {
                if let tasks = tasks, !tasks.isEmpty {
                    tasksListView(tasks: tasks)
                } else {
                    noTasksView
                }
            }
        }
    }
    
    // Know More Section
    var knowMoreSection: some View {
        HStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("Saiba mais:")
                    .font(.robotoMedium(size: .big))
                
                if let services = services, !services.isEmpty {
                    servicesScrollView(services: services)
                }
            }
            Spacer()
        }
    }
}

// MARK: - Subcomponents
private extension PetHomeView {
    // Pets Components
    var addPetButton: some View {
        CircularButton(
            size: 30,
            font: .robotoSemiBold(size: .great),
            action: { viewModel.presentAddPet() }
        )
        .sheet(isPresented: $viewModel.showAddPetSheet) {
            PetRegisterView()
        }
    }
    
    func petsScrollView(pets: [PetModel]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(pets) { pet in
                    PetButton(
                        pet: pet,
                        isSelected: false,
                        action: {}
                    )
                }
            }
        }
    }
    
    var noPetsButton: some View {
        PetButton(
            pet: PetModel.makePlaceholder(type: .addPet),
            action: {}
        )
    }
    
    // Tasks Components
    func tasksListView(tasks: [PetTaskModel]) -> some View {
        ZStack(alignment: .bottomTrailing) {
            VStack {
                Text("Próximas tarefas:")
                    .font(.robotoMedium(size: .big))
                ForEach(tasks) { task in
                    PetTaskCard(presenter: PetTaskCardPresenter(task: task))
                }
            }
            addTaskButton
        }
    }
    
    var addTaskButton: some View {
        CircularButton(
            font: .robotoMedium(size: .biggest),
            action: { viewModel.presentAddTask() }
        )
        .sheet(isPresented: $viewModel.showAddTaskSheet) {
            // CreateTaskView()
        }
    }
    
    var noTasksView: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Você não tem nenhuma tarefa!")
                    .font(.robotoMedium(size: .medium))
                    .foregroundColor(.primary)
                
                Text("Crie tarefas para organizar o seu dia")
                    .font(.robotoLight(size: .small))
                    .foregroundColor(.secondary)
                
                PJButton(
                    title: "Criar tarefa",
                    buttonType: .primaryType,
                    action: { /* Action */ }
                )
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(asset: .tasks)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: .black.opacity(0.1), radius: 6, x: 0, y: 3)
    }
    
    // Services Components
    func servicesScrollView(services: [ServiceModel]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack() {
                ForEach(services) { service in
                    ServiceItemView(service: service)
                }
            }
        }
    }
}

// MARK: - Preview
struct PetHomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PetHomeView(
                pets: PetModel.samplePets,
                tasks: PetTaskModel.sampleTasks,
                services: ServiceModel.mockServices
            )
            .previewDisplayName("Completa")
            
            PetHomeView(services: ServiceModel.mockServices)
                .previewDisplayName("Sem tarefas e Pets")
        }
    }
}
