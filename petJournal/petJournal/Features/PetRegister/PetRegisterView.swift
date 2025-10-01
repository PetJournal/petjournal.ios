import SwiftUI

struct PetRegisterView: View {
    @StateObject private var viewModel = PetRegisterViewModel.shared
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        mainContent()
            .background(
                Image(.petPaws)
                    .opacity(0.9),
                alignment: .bottom
            )
            .navigationBarHidden(true)
            .errorAlert(viewModel: viewModel)
    }
}

// MARK: - Main Components
private extension PetRegisterView {
    private func mainContent() -> some View {
        VStack(alignment: .leading, spacing: 16) {
            customNavigationBar(title: "Editar dados do Pet") {
                dismiss()
            }
            
            ScrollView {
                VStack(spacing: 16) {
                    petImageSection()
                    petNameField()
                    breedField()
                    sizeField()
                    birthDateField()
                    weightField()
                    animalTypeField()
                    genderSelection()
                    castrationSelection()
                    saveButton()
                }
                .padding()
            }
        }
    }
}

// MARK: - Form Fields Components
private extension PetRegisterView {
    func petNameField() -> some View {
        FormField(title: "Nome do pet") {
            TextField("Nome do pet", text: $viewModel.petName)
                .textFieldStyle()
        }
    }
    
    func breedField() -> some View {
        FormField(title: "Raça") {
            AutoCompleteSelect(
                selectedItem: $viewModel.breedName,
                items: viewModel.getBreed(),
                placeholder: "Qual a raça?"
            )
        }
    }
    
    func sizeField() -> some View {
        FormField(title: "Porte") {
            AutoCompleteSelect(
                selectedItem: $viewModel.size,
                items: viewModel.getSize(),
                placeholder: "Qual o porte?"
            )
        }
    }
    
    func birthDateField() -> some View {
        FormField(title: "Data de nascimento") {
            TextField("dd/mm/aaaa", text: $viewModel.dateOfBirth)
                .textFieldStyle()
                .keyboardType(.numberPad)
                .dateFormatter(text: $viewModel.dateOfBirth)
        }
    }
    
    func weightField() -> some View {
        FormField(title: "Peso") {
            TextField("Peso", text: $viewModel.weight)
                .textFieldStyle()
                .keyboardType(.decimalPad)
        }
    }
    
    func animalTypeField() -> some View {
        FormField(title: "Tipo") {
            AutoCompleteSelect(
                selectedItem: $viewModel.type,
                items: viewModel.getAnimalType(),
                placeholder: "Qual o tipo do animal?"
            )
        }
    }
}

// MARK: - Selection Components
private extension PetRegisterView {
    func genderSelection() -> some View {
        SelectionField(title: "Sexo") {
            HStack {
                selectionButton(
                    text: "Macho",
                    isSelected: viewModel.gender == "M",
                    action: { viewModel.gender = "M" }
                )
                
                Spacer()
                
                selectionButton(
                    text: "Fêmea",
                    isSelected: viewModel.gender == "F",
                    action: { viewModel.gender = "F" }
                )
            }
            .padding(.horizontal)
        }
    }
    
    func castrationSelection() -> some View {
        SelectionField(title: "Castrado") {
            HStack {
                selectionButton(
                    text: "Sim",
                    isSelected: viewModel.castrated.lowercased() == "sim",
                    action: { viewModel.castrated = "Sim" }
                )
                
                Spacer()
                
                selectionButton(
                    text: "Não",
                    isSelected: viewModel.castrated.lowercased() == "não",
                    action: { viewModel.castrated = "Não" }
                )
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - Action Components
private extension PetRegisterView {
    func saveButton() -> some View {
        Button(action: {
            Task {
                await viewModel.registerPet()
            }
        }) {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: Color(.petPrimary500)))
            } else {
                Text("Salvar")
                    .font(.headline)
                    .foregroundColor(Color(.petPrimary500))
            }
        }
        .buttonStyle(PrimaryButtonStyle())
        .disabled(viewModel.isLoading)
    }
}

// MARK: - Image Components
private extension PetRegisterView {
    func petImageSection() -> some View {
        HStack {
            PetImageView(image: viewModel.image)
                .task {
                    await viewModel.getImage()
                }
            
            editImageButton()
            deleteImageButton()
        }
        .offset(x: 35)
    }
    
    func editImageButton() -> some View {
        Button {
            // TODO: Implementar seleção de imagem da galeria
        } label: {
            VStack {
                Image(.icPencil)
                    .foregroundStyle(Color.white)
            }
            .frame(minWidth: 30.0, minHeight: 30.0)
            .background(Color(.petPrimary500))
            .cornerRadius(12)
        }
        .offset(x: -50, y: +50)
    }
    
    func deleteImageButton() -> some View {
        Button {
            viewModel.image = UIImage(named: "banner_01")!
        } label: {
            Image("ic_trash")
        }
        .offset(x: 30, y: -50)
    }
}

// MARK: - Helper Views
private extension PetRegisterView {
    func selectionButton(text: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(text)
                .font(.headline)
                .foregroundColor(isSelected ? .white : Color(.petPrimary500))
                .frame(minWidth: 121.00, maxWidth: 121.00, minHeight: 40.00, maxHeight: 40.00)
                .background(isSelected ? Color(.petPrimary500) : Color(.white))
                .overlay(
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(Color.gray, lineWidth: isSelected ? 0 : 1)
                )
                .cornerRadius(50)
                .shadow(color: isSelected ? Color.black.opacity(0.25) : .clear, radius: 10, x: 3, y: 4)
        }
    }
}

// MARK: - View Modifiers
private struct FormField<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.robotoMedium(size: .great))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            content
        }
    }
}

private struct SelectionField<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.robotoMedium(size: .great))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            content
        }
    }
}

private struct PetImageView: View {
    let image: UIImage
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(minWidth: 150, maxWidth: 150, minHeight: 150, maxHeight: 153)
            .clipped()
            .cornerRadius(18.0)
    }
}

private struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(minWidth: 121.00, maxWidth: 121.00,
                   minHeight: 40.00, maxHeight: 40.00)
            .background(Color.theme.petWhite)
            .cornerRadius(50)
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.25), radius: 10, x: 3, y: 4)
            .padding(.top, 16)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
    }
}

// MARK: - View Extensions
private extension View {
    func errorAlert(viewModel: PetRegisterViewModel) -> some View {
        alert("Erro", isPresented: Binding<Bool>(
            get: { viewModel.errorMessage != nil },
            set: { _ in viewModel.errorMessage = nil }
        )) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
    }
}

// MARK: - TextField Style Extension
extension TextField {
    func textFieldStyle() -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
            .padding(.leading)
            .padding(.vertical, 10)
            .background(Color.secondary.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

// MARK: - Previews
#Preview {
    PetRegisterView()
        .environmentObject(NavigationRouter())
}
