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
                MainContentView(
                    firstName: viewModel.firstName,
                    lastName: viewModel.lastName,
                    pets: pets,
                    tasks: tasks,
                    services: services, 
                    banners: banners
                )
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

// MARK: - Main Content Components
private struct MainContentView: View {
    let firstName: String
    let lastName: String
    var pets: [PetModel]?
    var tasks: [PetTaskModel]?
    var services: [ServiceModel]?
    let banners: [HomeBanner]?
    
    var body: some View {
        VStack(spacing: 20) {
            TitleView(firstName: firstName, lastName: lastName)
            BannersView(banners: banners)
            PetsView(pets: pets)
            TasksView(tasks: tasks)
            KnowMoreView(services: services)
            Spacer(minLength: 20)
        }
        .padding(.horizontal, 16)
    }
}

// MARK: - Subcomponents
private struct TitleView: View {
    let firstName: String
    let lastName: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text("Olá, \(firstName) \(lastName)!")
                    .font(.robotoLight(size: .large))
            }
            Spacer()
        }
        .padding(.top, 20)
    }
}

private struct BannersView: View {
    let banners: [HomeBanner]?    
    var body: some View {
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

private struct PetsView: View {
    var pets: [PetModel]?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("Meus pets:")
                    .font(.robotoMedium(size: .big))
                
                if let pets = pets, !pets.isEmpty {
                    PetsScrollView(pets: pets)
                } else {
                    AddPetButton()
                }
            }
            Spacer()
        }
    }
}

private struct PetsScrollView: View {
    let pets: [PetModel]
    
    var body: some View {
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
}

private struct AddPetButton: View {
    var body: some View {
        PetButton(
            pet: PetModel.makePlaceholder(type: .addPet),
            action: {}
        )
    }
}

private struct TasksView: View {
    var tasks: [PetTaskModel]?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 20) {
                if let tasks = tasks, !tasks.isEmpty {
                    TasksListView(tasks: tasks)
                } else {
                    NoTasksView()
                }
            }
        }
    }
}

private struct TasksListView: View {
    let tasks: [PetTaskModel]
    
    var body: some View {
        Group {
            Text("Próximas tarefas:")
                .font(.robotoMedium(size: .big))
            
            ForEach(tasks) { task in
                PetTaskCard(presenter: PetTaskCardPresenter(task: task))
            }
        }
    }
}

private struct NoTasksView: View {
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Você não tem nenhuma tarefa!")
                    .font(.robotoMedium(size: .medium))
                    .foregroundColor(.primary)
                
                Text("Crie tarefas para organizar o seu dia")
                    .font(.robotoLight(size: .small))
                    .foregroundColor(.secondary)
                
                PJButton(title: "Criar tarefa",
                         buttonType: .primaryType) {
                    // Action
                }
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
}

private struct KnowMoreView: View {
    var services: [ServiceModel]?
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("Saiba mais:")
                    .font(.robotoMedium(size: .big))
                
                if let services = services, !services.isEmpty {
                    ServicesScrollView(services: services)
                }
            }
            Spacer()
        }
    }
}

private struct ServicesScrollView: View {
    let services: [ServiceModel]
    
    var body: some View {
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
