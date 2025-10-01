import SwiftUI

struct PetListView: View {
    @EnvironmentObject private var navigationRouter: NavigationRouter
    @StateObject private var viewModel = PetListViewModel()
    
    var body: some View {
        ZStack {
            backgroundImage
            mainContent
        }
        .task { await viewModel.fetchPets() }
    }
}

// MARK: - Subviews
private extension PetListView {
    var backgroundImage: some View {
        Image(.stepsBackground)
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
            petsContent
            Spacer()
        }
    }
    
    var titleView: some View {
        Text("Vamos ver qual pet?")
            .font(.robotoSemiBold(size: .large))
            .padding(.top, 120)
    }
    
    var petsContent: some View {
        PetsScrollView(
            pets: viewModel.pets,
            addPetAction: {
                navigationRouter.navigate(to: .petRegister)
            },
            onPetTap: { pet in
                navigationRouter.navigate(to: .petProfile(pet: pet))
            },
            reloadAction: {
                await viewModel.fetchPets()
            }
        )
        .animation(.easeInOut(duration: 0.3), value: viewModel.pets)
    }
}

// MARK: - Subcomponents
private struct PetsScrollView: View {
    let pets: [PetModel]
    let addPetAction: () -> Void
    let onPetTap: (PetModel) -> Void
    let reloadAction: () async -> Void
    let gridColumns = Array(repeating: GridItem(.flexible()),
                            count: 2)
    
    var body: some View {
        ScrollView {
            VStack {
                LazyVGrid(
                    columns: gridColumns) {
                    ForEach(pets, id: \.id) { pet in
                        PetButton(type: .pet(pet)) {
                            onPetTap(pet)
                        }
                    }
                    PetButton(type: .addPet) {
                        addPetAction()
                    }
                }
            }
            .frame(maxWidth: 250)
        }
        .refreshable {
            await reloadAction()
        }
    }
}



// MARK: - Preview
#Preview {
    PetListView()
        .environmentObject(NavigationRouter())
}
