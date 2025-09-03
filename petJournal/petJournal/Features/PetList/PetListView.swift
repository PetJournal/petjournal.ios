import SwiftUI

struct PetListView: View {
    @State private var path = NavigationPath()
    @StateObject private var viewModel = PetListViewModel.shared
    
    var body: some View {
        NavigationStack(path: $path) {
            ZStack {
                backgroundImage
                mainContent
            }
            .navigationDestination(for: Route.self,
                                   destination: handleNavigation)
            .task{ await viewModel.fetchPets() }
        }
    }
}

// MARK: - Subviews
private extension PetListView {
    var backgroundImage: some View {
        Image(asset: .petListBackground)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
            .foregroundStyle(Color.theme.petPrimary100)
            .padding(.top, 80)
            .offset(y: -70)
    }
    
    var mainContent: some View {
        VStack(spacing: 30) {
            titleView
            addPetButton
            petsContent
            Spacer()
        }
    }
    
    var titleView: some View {
        Text("Vamos ver qual pet?")
            .font(.robotoSemiBold(size: .large))
            .padding(.top, 120)
    }
    
    var addPetButton: some View {
        PetButton(pet: PetModel.makePlaceholder(type: .addPet)) {
            path.append(Route.petRegister)
        }
    }
    
    var petsContent: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
                    .padding()
            } else {
                PetsScrollView(pets: viewModel.pets) { pet in
                    path.append(Route.petProfile(pet: pet))
                }
            }
        }
    }
}

// MARK: - Subcomponents
private struct PetsScrollView: View {
    let pets: [PetModel]
    let onPetTap: (PetModel) -> Void
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(pets, id: \.id) { pet in
                    PetButton(pet: pet) {
                        onPetTap(pet)
                    }
                }
            }
            .padding()
        }
    }
}

// MARK: - Navigation
private extension PetListView {
    @ViewBuilder
    func handleNavigation(for route: Route) -> some View {
        switch route {
        case .petRegister:
            PetRegisterView()
        case .petProfile(let pet):
            PetProfileView(pet: pet)
        default:
            EmptyView()
        }
    }
}

// MARK: - Preview
#Preview {
    PetListView()
        .environmentObject(NavigationRouter())
}


