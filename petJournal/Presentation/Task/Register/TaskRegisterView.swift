import SwiftUI

struct TaskRegisterView: View {
    @StateObject private var viewModel = TaskRegisterViewModel()
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                VStack(alignment: .leading, spacing: 24) {
                    taskTypeSection
                    taskNameField
                    descriptionField
                    petSelectionSection
                    recurrenceSection
                    observationField
                    saveButton
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
            }
            
            Image(.petPaws)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .ignoresSafeArea(edges: .bottom)
        }
        .navigationTitle("Nova tarefa")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: { dismiss() }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.theme.petPrimary500)
                }
            }
        }
        .task {
            await viewModel.fetchPets()
        }
        .alert(viewModel.alertMessage, isPresented: $viewModel.showAlert) {
            Button("OK") {
                if viewModel.isSuccessAlert {
                    dismiss()
                }
            }
        }
    }
    
    // MARK: - Task Type Section
    private var taskTypeSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Essa tarefa é...")
                .font(.robotoMedium(size: .small))
                .foregroundColor(.theme.petBlack)
            
            LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 12) {
                TaskButton(
                    title: TaskType.vaccine.rawValue,
                    primaryColor: .theme.petOrange,
                    isSelected: Binding(
                        get: { viewModel.selectedTaskType == .vaccine },
                        set: { if $0 { viewModel.selectedTaskType = .vaccine } }
                    )
                )
                
                TaskButton(
                    title: TaskType.consultation.rawValue,
                    primaryColor: .theme.petGreen,
                    isSelected: Binding(
                        get: { viewModel.selectedTaskType == .consultation },
                        set: { if $0 { viewModel.selectedTaskType = .consultation } }
                    )
                )
                
                TaskButton(
                    title: TaskType.medicine.rawValue,
                    primaryColor: .theme.petSecondary500,
                    isSelected: Binding(
                        get: { viewModel.selectedTaskType == .medicine },
                        set: { if $0 { viewModel.selectedTaskType = .medicine } }
                    )
                )
                
                TaskButton(
                    title: "Banho",
                    primaryColor: .theme.petCerise,
                    isSelected: .constant(false)
                )
                
                TaskButton(
                    title: "Ração",
                    primaryColor: .theme.petCarnation,
                    isSelected: .constant(false)
                )
            }
        }
    }
    
    // MARK: - Task Name Field
    private var taskNameField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Nome da tarefa")
                .font(.robotoMedium(size: .small))
                .foregroundColor(.theme.petBlack)
            
            TextEditor(text: $viewModel.taskName)
                .frame(height: 48)
                .padding(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.theme.petGray800, lineWidth: 1)
                )
                .overlay(alignment: .topLeading) {
                    if viewModel.taskName.isEmpty {
                        Text("Digite aqui o nome da tarefa")
                            .foregroundColor(.theme.petGray300)
                            .font(.robotoMedium(size: .small))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 16)
                            .allowsHitTesting(false)
                    }
                }
        }
    }
    
    // MARK: - Description Field
    private var descriptionField: some View {
        VStack(alignment: .leading) {
            Text("Descrição")
                .font(.robotoMedium(size: .small))
                .foregroundColor(.theme.petBlack)
            
            TextEditor(text: $viewModel.taskDescription)
                .frame(height: 100)
                .padding(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.theme.petGray800, lineWidth: 1)
                )
                .overlay(alignment: .topLeading) {
                    if viewModel.taskDescription.isEmpty {
                        Text("Digite aqui a descrição da tarefa")
                            .foregroundColor(.theme.petGray300)
                            .font(.robotoMedium(size: .small))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 16)
                            .allowsHitTesting(false)
                    }
                }
        }
    }
    
    // MARK: - Pet Selection Section
    private var petSelectionSection: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Quais pets precisam dessa tarefa?")
                .font(.robotoMedium(size: .small))
                .foregroundColor(.theme.petBlack)
            
            PetSelectionList(
                pets: viewModel.availablePets,
                allowsMultipleSelection: true,
                showSelectAllButton: true,
                selectedPets: Binding(
                    get: {
                        viewModel.availablePets.filter { viewModel.selectedPets.contains($0.id) }
                    },
                    set: { newValue in
                        viewModel.selectedPets = Set(newValue.map { $0.id })
                    }
                )
            )
        }
    }
    
    // MARK: - Recurrence Section
    private var recurrenceSection: some View {
        DateTimeSelector()
    }
    
    // MARK: - Observation Field
    private var observationField: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Observação")
                .font(.robotoMedium(size: .small))
                .foregroundColor(.theme.petBlack)
            
            TextEditor(text: $viewModel.observation)
                .frame(height: 100)
                .padding(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.theme.petGray800, lineWidth: 1)
                )
                .overlay(alignment: .topLeading) {
                    if viewModel.observation.isEmpty {
                        Text("Digite aqui a sua observação")
                            .foregroundColor(.theme.petGray300)
                            .font(.robotoMedium(size: .small))
                            .padding(.horizontal, 12)
                            .padding(.vertical, 16)
                            .allowsHitTesting(false)
                    }
                }
        }
    }
    
    // MARK: - Save Button
    private var saveButton: some View {
        HStack {
            Spacer()
            PJButton.save("Salvar") {
                Task {
                    await viewModel.save()
                }
            }
            .disabled(!viewModel.isValid || viewModel.isLoading)
            Spacer()
        }
        .padding(.top, 16)
        .padding(.bottom, 32)
    }
}

#Preview {
    NavigationStack {
        TaskRegisterView()
    }
}
