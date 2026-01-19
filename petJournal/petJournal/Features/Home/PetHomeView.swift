import SwiftUI

// MARK: - Main View
struct PetHomeView: View {
    @StateObject private var viewModel = PetHomeViewModel()
    var pets: [PetModel]?
    var tasks: [PetTaskModel]?
    var services: [TagModel]?
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
            await viewModel.loadInitialData()
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
                    noPetsView
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
                    NoTasksView { viewModel.presentAddTask()}
                        .sheet(isPresented: $viewModel.showAddTaskSheet) {
                            // CreateTaskView()
                        }
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
                
                if !viewModel.tags.isEmpty {
                    servicesScrollView(services: viewModel.tags)
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
                        type: .pet(pet),
                        isSelected: false,
                        action: {}
                    )
                }
            }
        }
    }
    
    var noPetsView: some View {
        Text("Ainda sem pet.")
            .padding()
            .frame(width: 100,height: 100)
            .background(Color.theme.petGray300)
            .foregroundColor(Color.theme.petGray800)
            .cornerRadius(16)
    }
    
    // Tasks Components
    func tasksListView(tasks: [PetTaskModel]) -> some View {
        ZStack(alignment: .bottomTrailing) {
            LazyVStack(alignment: .leading) {
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
    
    // Services Components
    func servicesScrollView(services: [TagModel]) -> some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack() {
                ForEach(services) { service in
                    ServiceTagItemView(tag: service)
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
                services: TagModel.mockServices
            )
            .previewDisplayName("Completa")
            
            PetHomeView(services: nil)
                .previewDisplayName("Sem tarefas e Pets")
        }
    }
}
