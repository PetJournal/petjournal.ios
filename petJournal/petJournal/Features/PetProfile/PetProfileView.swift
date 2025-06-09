import SwiftUI

//FIXME: Move to separete file
protocol PetProfileViewModelProtocol {
    var pet: PetModel { get }
    var ageText: String { get }
    func editPet()
}
//FIXME: Move to separete file
final class PetProfileViewModel: PetProfileViewModelProtocol, ObservableObject {
    private let petModel: PetModel
    private let coordinator: PetProfileCoordinatorProtocol
    
    init(pet: PetModel, coordinator: PetProfileCoordinatorProtocol) {
        self.petModel = pet
        self.coordinator = coordinator
    }
    
    var pet: PetModel {
        return petModel
    }
    
    var ageText: String {
        calculateAge(from: petModel.dateOfBirth)
    }
    
    func editPet() {
        coordinator.navigateToEditPet(pet: petModel)
    }
    
    private func calculateAge(from dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        guard let birthDate = dateFormatter.date(from: dateString) else {
            return "Idade desconhecida"
        }
        
        let calendar = Calendar.current
        let ageComponents = calendar.dateComponents([.year, .month], from: birthDate, to: Date())
        
        if let years = ageComponents.year, years > 0 {
            return "\(years) ano\(years > 1 ? "s" : "")"
        } else if let months = ageComponents.month, months > 0 {
            return "\(months) mês\(months > 1 ? "es" : "")"
        } else {
            return "Recém-nascido"
        }
    }
}

protocol PetProfileCoordinatorProtocol {
    func navigateToEditPet(pet: PetModel)
}

struct PetProfileView<ViewModel: PetProfileViewModelProtocol & ObservableObject>: View {
    @ObservedObject var viewModel: ViewModel
    
    init(viewModel: ViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        VStack(spacing: 16) {
            petHeaderView
            Spacer()
        }
        .padding()
    }
    
    private var petHeaderView: some View {
        HStack(alignment: .top, spacing: 16) {
            petImageView
            petInfoView
        }
        .frame(maxWidth: .infinity)
    }
    
    private var petImageView: some View {
        GeometryReader { geometry in
            viewModel.pet.getImage()
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: geometry.size.width, height: geometry.size.width)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
        }
        .aspectRatio(1, contentMode: .fit)
    }
    
    private var petInfoView: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topTrailing) {

                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.theme.petPrimaryBackground)
                    .frame(width: geometry.size.width, height: geometry.size.width)
                
                VStack(alignment: .leading, spacing: 8) {
                    VStack(alignment: .leading, spacing: 6) {
                        // Nome do pet (único com fonte maior)
                        Text(viewModel.pet.petName)
                            .font(.robotoSemiBold(size: .biggest))
                            .foregroundColor(Color.theme.petPrimary500)
                            .lineLimit(1)
                            .minimumScaleFactor(0.7)
                            .padding(.top, 8)
                        
                        // Species/Gender
                        HStack {
                            Text(viewModel.pet.specie.detail)
                                .font(.robotoSemiBold(size: .medium))
                            Text(".")
                                .font(.robotoSemiBold(size: .medium))
                            Text(viewModel.pet.gender)
                                .font(.robotoSemiBold(size: .medium))
                        }
                        
                        // Breed
                        HStack {
                            Text(viewModel.pet.breedAlias ?? "")
                                .font(.robotoSemiBold(size: .medium))
                        }
                        
                        // Age/Weight
                        HStack {
                            Text(viewModel.ageText)
                                .font(.robotoSemiBold(size: .medium))
                            Text(".")
                                .font(.robotoSemiBold(size: .medium))
                            Text("\(viewModel.pet.weight, specifier: "%.1f") kg")
                                .font(.robotoSemiBold(size: .medium))
                        }
                    }
                    .font(.subheadline)
                    .foregroundColor(Color.theme.petPrimary500)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 8)
                    
                    Spacer()
                }
                .padding(8)
                .frame(width: geometry.size.width, height: geometry.size.width, alignment: .topLeading)
                
                // Botão de edição
                editButton
                    .padding([.top, .trailing], 12)
            }
        }
        .aspectRatio(1, contentMode: .fit)
    }
    
    private var editButton: some View {
        Button(action: {
            viewModel.editPet()
        }) {
            Image(systemName: "pencil")
                .foregroundColor(Color.theme.petWhite)
                .padding(8)
                .background(Color.theme.petPrimary500)
                .clipShape(Circle())
        }
    }
}

// MARK: - Preview
struct PetProfileView_Previews: PreviewProvider {
    static var previews: some View {
        let mockCoordinator = MockPetProfileCoordinator()
        let viewModel = PetProfileViewModel(
            pet: PetModel.mockPets.randomElement()!,
            coordinator: mockCoordinator
        )
        
        return NavigationView {
            PetProfileView(viewModel: viewModel)
                
        }.previewDisplayName("Inicio Perfil de Pet")
    }
}

class MockPetProfileCoordinator: PetProfileCoordinatorProtocol {
    func navigateToEditPet(pet: PetModel) {
        print("Navigate to edit pet: \(pet.petName)")
    }
}
	
