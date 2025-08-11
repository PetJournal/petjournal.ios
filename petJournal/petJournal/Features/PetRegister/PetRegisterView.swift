import SwiftUI

struct PetRegisterView: View {
    @StateObject private var viewModel = PetRegisterViewModel.shared
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                backgroundImage(geo: geo)
                mainContent(geo: geo)
            }
        }
        .navigationBarHidden(true)
        .alert("Erro", isPresented: Binding<Bool>(
            get: { viewModel.errorMessage != nil },
            set: { _ in viewModel.errorMessage = nil }
        )) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
    }
    
    // MARK: - Main Components
    
    private func mainContent(geo: GeometryProxy) -> some View {
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
    
    private func backgroundImage(geo: GeometryProxy) -> some View {
        Image(.petPaws)
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
            .foregroundStyle(Color(.petPrimary500))
            .frame(width: geo.size.width, height: geo.size.height - 200, alignment: .center)
            .offset(y: 200)
            .opacity(1.0)
    }
    
    // MARK: - Form Fields
    
    private func petNameField() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Nome do pet")
                .font(.robotoMedium(size: .great))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("Nome do pet", text: $viewModel.petName)
                .textFieldStyle()
        }
    }
    
    private func breedField() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Raça")
                .font(.robotoMedium(size: .great))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            AutoCompleteSelect(
                selectedItem: $viewModel.breedName,
                items: viewModel.getBreed(),
                placeholder: "Qual a raça?"
            )
        }
    }
    
    private func sizeField() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Porte")
                .font(.robotoMedium(size: .great))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            AutoCompleteSelect(
                selectedItem: $viewModel.size,
                items: viewModel.getSize(),
                placeholder: "Qual o porte?"
            )
        }
    }
    
    private func birthDateField() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Data de nascimento")
                .font(.robotoMedium(size: .great))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("dd/mm/aaaa", text: $viewModel.dateOfBirth)
                .textFieldStyle()
                .keyboardType(.numberPad)
        }
    }
    
    private func weightField() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Peso")
                .font(.robotoMedium(size: .great))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("Peso", text: $viewModel.weight)
                .textFieldStyle()
                .keyboardType(.decimalPad)
        }
    }
    
    private func animalTypeField() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Tipo")
                .font(.robotoMedium(size: .great))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            AutoCompleteSelect(
                selectedItem: $viewModel.type,
                items: viewModel.getAnimalType(),
                placeholder: "Qual o tipo do animal?"
            )
        }
    }
    
    // MARK: - Selection Components
    
    private func genderSelection() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Sexo")
                .font(.robotoMedium(size: .great))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                selectionButton(
                    text: "Macho",
                    isSelected: viewModel.gender.lowercased() == "macho",
                    action: { viewModel.gender = "Macho" }
                )
                
                Spacer()
                
                selectionButton(
                    text: "Fêmea",
                    isSelected: viewModel.gender.lowercased() == "fêmea",
                    action: { viewModel.gender = "Fêmea" }
                )
            }
            .padding(.horizontal)
        }
    }
    
    private func castrationSelection() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Castrado")
                .font(.robotoMedium(size: .great))
                .frame(maxWidth: .infinity, alignment: .leading)
            
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
    
    // MARK: - Action Components
    
    private func saveButton() -> some View {
        Button(action: {
            viewModel.registerPet()
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
        .frame(minWidth: 121.00, maxWidth: 121.00, minHeight: 40.00, maxHeight: 40.00)
        .background(Color(.white))
        .cornerRadius(50)
        .overlay(
            RoundedRectangle(cornerRadius: 50)
                .stroke(Color.gray, lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.25), radius: 10, x: 3, y: 4)
        .padding(.top, 16)
        .disabled(viewModel.isLoading)
    }
    
    // MARK: - Helper Views
    
    private func petImageSection() -> some View {
        HStack {
            Image(uiImage: viewModel.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .task {
                    await viewModel.getImage()
                }
                .frame(minWidth: 150, maxWidth: 150, minHeight: 150, maxHeight: 153)
                .clipped()
                .cornerRadius(18.0)
            
            editImageButton()
            deleteImageButton()
        }
        .offset(x: 35)
    }
    
    private func editImageButton() -> some View {
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
    
    private func deleteImageButton() -> some View {
        Button {
            viewModel.image = UIImage(named: "banner_01")!
        } label: {
            Image("ic_trash")
        }
        .offset(x: 30, y: -50)
    }
    
    private func selectionButton(text: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
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
