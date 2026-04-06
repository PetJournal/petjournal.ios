import SwiftUI

// MARK: - Protocols
protocol PetTaskCardDisplayLogic {
    var task: PetTaskModel { get }
    var isExpanded: Bool { get set }
    func toggleExpansion()
}

// MARK: - Presenter
class PetTaskCardPresenter: ObservableObject, PetTaskCardDisplayLogic {
    @Published var isExpanded: Bool = false
    let task: PetTaskModel
    
    init(task: PetTaskModel) {
        self.task = task
    }
    
    func toggleExpansion() {
        withAnimation(.interactiveSpring) {
            isExpanded.toggle()
        }
    }
}

// MARK: - View
struct PetTaskCard: View {
    @ObservedObject var presenter: PetTaskCardPresenter
    private let gridColumns = Array(repeating: GridItem(.flexible()), count: 3)
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            cardContent
        }
    }
    
    private var cardContent: some View {
        VStack(spacing: 0) {
            headerSection
            if presenter.isExpanded {
                expandedContent
            }
            toggleButton
        }
        .background(presenter.task.isPast ? Color.theme.petCards : Color.theme.petBackground)
        .cornerRadius(12)
        .shadow(radius: 2)
    }
    
    private var headerSection: some View {
        HStack(alignment: .top) {
            titleSection
            descriptionSection
        }
        .padding(14)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading) {
            Text(presenter.task.title)
                .font(.robotoMedium(size: .large))
            
            Text(presenter.task.note)
                .font(.robotoLight(size: .medium))
                .foregroundColor(Color.theme.petGray800)
            
            if presenter.isExpanded {
                petImagesGrid
            }
        }
        .frame(maxWidth: UIScreen.main.bounds.width / 3, 
               alignment: .leading)
    }
    
    private var petImagesGrid: some View {
        LazyVGrid(columns: gridColumns) {
            ForEach(presenter.task.pets.indices, id: \.self) { index in
                if let petImage = presenter.task.pets[index].computedPetImage {
                    petImage
                        .resizable()
                        .scaledToFill()
                        .frame(width: 30, height: 30)
                        .clipShape(Circle())
                } else {
                    Image(.icPawFilled)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                        .foregroundColor(.theme.petPrimary500)
                }
            }
        }
        .padding(.trailing)
    }
    
    private var descriptionSection: some View {
        Text(presenter.task.description)
            .font(presenter.isExpanded ? .robotoLight(size: .medium) : .robotoMedium(size: .medium))
            .foregroundColor(Color.theme.petBlack)
            .frame(maxWidth: .infinity, 
                   maxHeight: .infinity,
                   alignment: presenter.isExpanded ? .leading : .topLeading)
            .lineLimit(presenter.isExpanded ? nil : 2)
    }
    
    private var expandedContent: some View {
        ZStack {
            backgroundIcon
            editButton
        }
        .frame(height: 30)
        .padding(12)
    }
    
    private var backgroundIcon: some View {
        Image(.icMedicine)
            .resizable()
            .scaledToFit()
            .frame(width: 150, height: 150)
            .foregroundColor(Color.theme.petSecondary500.opacity(0.5))
            .offset(x: -140, y: -20)
    }
    
    private var editButton: some View {
        Button(action: {}) {
            Text("Editar tarefa")
                .foregroundColor(Color.theme.petSecondary500)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 8)
        }
        .tint(Color.theme.petSecondary500)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.theme.petGray800, lineWidth: 1)
        )
        .frame(width: (UIScreen.main.bounds.width) / 3)
    }
    
    private var toggleButton: some View {
        Button(action: presenter.toggleExpansion) {
            Text(presenter.isExpanded ? "Ver menos" : "Ver mais")
                .font(.robotoMedium(size: .medium))
                .foregroundColor(presenter.task.isPast ? Color.theme.petBlack : Color.theme.petBackground)
                .frame(maxWidth: .infinity)
                .padding()
        }
        .frame(height: 30)
        .buttonStyle(.borderedProminent)
        .tint(Color.theme.petSecondary500)
        .clipped()
    }
}

// MARK: - Preview
struct PetTaskCard_Previews: PreviewProvider {
    static var previews: some View {
        return ScrollView {
            VStack(spacing: 20) {
                ForEach(PetTaskModel.previewList) { task in
                    PetTaskCard(presenter: PetTaskCardPresenter(task: task))
                }
                ForEach(PetTaskModel.previewHistoric) { task in
                    PetTaskCard(presenter: PetTaskCardPresenter(task: task))
                }
            }
        }
        .previewLayout(.sizeThatFits)
        .previewDisplayName("Exemplos de tarefas")
    }
}
