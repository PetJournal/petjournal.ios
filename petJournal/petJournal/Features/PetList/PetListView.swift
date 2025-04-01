import SwiftUI

struct PetListView: View {
    @State private var activeDestination: DestinationMock?
    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Image(asset: .petListBackground)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
                    .foregroundStyle(Color.theme.petPrimary100)
                    .padding(.top, 80)
                    .offset(y: -70)
                
                VStack {
                    Text("Vamos ver qual pet?")
                        .font(.robotoSemiBold(size: .large))
                        .font(.title2)
                        .fontWeight(.semibold)
                        .padding(.top, 120)
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(PetModel.mockPets, id: \.self) { item in
                                NavigationLink(destination: MockDetailView()) {
                                    PetButton(pet: item, action: {
                                        activeDestination = .view1
                                    })
                                }
                            }
                            NavigationLink(destination: MockRegisterView()) {
                                PetButton(pet: PetModel.addPet, action: {
                                    activeDestination = .view2
                                })
                            }
                        }
                        .padding()
                    }.padding(50)
                    
                    NavigationLink(
                        destination: getDestinationView(),
                        tag: .view1,
                        selection: $activeDestination
                    ) { EmptyView() }
                    
                    NavigationLink(
                        destination: getDestinationView(),
                        tag: .view2,
                        selection: $activeDestination
                    ) { EmptyView() }
                    
                    Spacer()
                }
            }
        }
    }
}

//FIXME: Remove mock navigation
extension PetListView {
    // Retorna a view de destino apropriada
    private func getDestinationView() -> some View {
        Group {
            switch activeDestination {
            case .view1:
                MockDetailView()
            case .view2:
                MockRegisterView()
            case .none:
                EmptyView()
            }
        }
    }
}

struct MockDetailView: View {
    var body: some View {
        Text("Tela de DETALHES do Pet")
            .navigationTitle("Detalhes")
    }
}

struct MockRegisterView: View {
    var body: some View {
        Text("Tela de CADASTRO de Pet")
            .navigationTitle("Cadastro")
    }
}

enum DestinationMock {
    case view1, view2
}

#Preview {
    PetListView()
}
