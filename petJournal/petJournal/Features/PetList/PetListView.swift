import SwiftUI

struct PetListView: View {
    @EnvironmentObject private var navigationRouter: NavigationRouter
    @StateObject private var viewModel = PetListViewModel()
    
    var body: some View {
        mainContent
            .background(
                Image(.stepsBackground)
                    .resizable()
                    .scaledToFill()
                    .opacity(0.9)
            )
            .task { await viewModel.fetch() }
    }
}

// MARK: - Subviews
private extension PetListView {

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
            onRefresh: {
                await viewModel.fetch()
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
    let onRefresh: () async -> Void
    
    private let columns = Array(repeating: GridItem(.flexible()), count: 2)
    
    var body: some View {
        ScrollView {
            VStack {
                LazyVGrid(columns: columns) {
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
            await onRefresh()
        }
    }
}

// MARK: - Preview
#Preview {
    PetListView()
        .environmentObject(NavigationRouter())
}
