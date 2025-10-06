import SwiftUI

struct PetRegisterView: View {
    @StateObject private var viewModel: PetRegisterViewModel
    @Environment(\.dismiss) var dismiss
    
    init(pet: PetModel? = nil) {
        _viewModel = StateObject(wrappedValue: PetRegisterViewModel(pet: pet))
    }
    
    var body: some View {
        mainContent()
            .background(
                Image(.petPaws)
                    .opacity(0.9),
                alignment: .bottom
            )
            .navigationBarHidden(true)
            .errorAlert(viewModel: viewModel)

            .overlay {
                PetRegisterAlert(viewModel: viewModel)
            }
    }
}

// MARK: - Main Components
private extension PetRegisterView {
    private func mainContent() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            customNavigationBar(title: viewModel.pet != nil ? "Editar dados do Pet" : "Cadastrar novo Pet") {
                dismiss()
            }
            
            ScrollView {
                VStack(alignment: .center, spacing: 16) {
                    imageSection
                    nameField
                    breedField
                    sizeField
                    birthDateField
                    typeField
                    genderSelection
                    castrationSelection
                    saveButton
                }
                .padding()
            }
        }
    }
}

// MARK: - Image Section
private extension PetRegisterView {
    var imageSection: some View {
        ZStack {
            PetButton(type: .pet(viewModel.pet),
                      frameSize: 150, action: {})
            .task {
                await viewModel.loadSampleImage()
            }
        }
        .overlay(alignment: .bottomTrailing) {
            ActionButton(.icPencil, background: .theme.petPrimary500) {
                // TODO: Implementar seleção de imagem
            }
            .offset(x: -10, y: -35)
        }
        .overlay(alignment: .topTrailing) {
            ActionButton(.icTrash) {
                viewModel.showDeleteConfirmation()
            }
            .offset(x: 60)
        }
    }
}

// MARK: - Form Fields
private extension PetRegisterView {
    var nameField: some View {
        FormField(title: "Nome do pet") {
            TextField("Nome do pet", text: $viewModel.name)
                .textFieldStyle()
        }
    }
    
    var breedField: some View {
        FormField(title: "Raça") {
            AutoCompleteSelect(
                selectedItem: $viewModel.breed,
                items: viewModel.breeds,
                placeholder: "Qual a raça?"
            )
        }
    }
    
    var sizeField: some View {
        FormField(title: "Porte") {
            AutoCompleteSelect(
                selectedItem: $viewModel.size,
                items: viewModel.sizes,
                placeholder: "Qual o porte?"
            )
        }
    }
    
    var birthDateField: some View {
        FormField(title: "Data de nascimento") {
            TextField("dd/mm/aaaa", text: $viewModel.birthDate)
                .textFieldStyle()
                .keyboardType(.numberPad)
                .dateFormatter(text: $viewModel.birthDate)
        }
    }
    
    var typeField: some View {
        FormField(title: "Tipo") {
            AutoCompleteSelect(
                selectedItem: $viewModel.type,
                items: viewModel.animalTypes,
                placeholder: "Qual o tipo do animal?"
            )
        }
    }
}

// MARK: - Selections
private extension PetRegisterView {
    var genderSelection: some View {
        SelectionField(title: "Sexo") {
            HStack {
                PJButton.selection("Macho", isSelected: viewModel.gender == "M") {
                    viewModel.gender = "M"
                }
                Spacer()
                PJButton.selection("Fêmea", isSelected: viewModel.gender == "F") {
                    viewModel.gender = "F"
                }
            }
            .padding(.horizontal)
        }
    }
    
    var castrationSelection: some View {
        SelectionField(title: "Castrado") {
            HStack {
                PJButton.selection("Sim", isSelected: viewModel.isCastrated.lowercased() == "sim") {
                    viewModel.isCastrated = "Sim"
                }
                Spacer()
                PJButton.selection("Não", isSelected: viewModel.isCastrated.lowercased() == "não") {
                    viewModel.isCastrated = "Não"
                }
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - Actions
private extension PetRegisterView {
    var saveButton: some View {
        Group {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .theme.petPrimary500))
                    .frame(width: 121, height: 40)
            } else {
                PJButton.save("Salvar") {
                    Task { await viewModel.save() }
                }
            }
        }
        .disabled(viewModel.isLoading)
        .padding(.top, 16)
    }
}

// MARK: - Previews
#Preview("Cadastrar") {
    PetRegisterView()
        .environmentObject(NavigationRouter())
}
#Preview("Editar") {
    PetRegisterView(pet: PetModel.samplePets[0])
        .environmentObject(NavigationRouter())
}
