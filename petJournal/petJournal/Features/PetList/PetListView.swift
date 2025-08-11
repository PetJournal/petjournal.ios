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
            .navigationDestination(for: Route.self) { route in
                switch route {
                case .petRegister:
                    PetRegisterView()
                default:
                    EmptyView()
                }
            }
            .onAppear {
                viewModel.fetchPets()
            }
        }
    }
    
    // MARK: Subviews    
    private var backgroundImage: some View {
        Image(asset: .petListBackground)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
            .foregroundStyle(Color.theme.petPrimary100)
            .padding(.top, 80)
            .offset(y: -70)
    }
    
    private var mainContent: some View {
        VStack(spacing: 30) {
            titleView
            addPetButton
            petsList
            Spacer()
        }
    }
    
    private var titleView: some View {
        Text("Vamos ver qual pet?")
            .font(.robotoSemiBold(size: .large))
            .padding(.top, 120)
    }
    
    private var addPetButton: some View {
        PetButton(pet: PetModel.makePlaceholder(type: .addPet)) {
            path.append(Route.petRegister)
        }
    }
    
    private var petsList: some View {
        Group {
            if viewModel.isLoading {
                loadingView
            } else {
                scrollablePetsView
            }
        }
    }
    
    private var loadingView: some View {
        ProgressView()
            .padding()
    }
    
    private var scrollablePetsView: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.pets, id: \.id) { pet in
                    PetButton(pet: pet) {
                        path.append(Route.petProfile(pet: pet))
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    PetListView()
        .environmentObject(NavigationRouter())
}
