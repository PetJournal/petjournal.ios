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
            
            VStack {
                Spacer()
                Image(.petPaws)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .allowsHitTesting(false)
            }
            .ignoresSafeArea(.keyboard)
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
                ForEach(TagModel.mockServices) { tag in
                    TaskButton(
                        title: tag.name,
                        primaryColor: tag.colorValue,
                        isSelected: Binding(
                            get: { viewModel.selectedTag?.id == tag.id },
                            set: { if $0 { viewModel.selectedTag = tag } }
                        )
                    )
                }
            }
        }
    }
    
    // MARK: - Task Name Field
    private var taskNameField: some View {
        PJTextEditorView(
            title: "Nome da tarefa",
            placeholder: "Digite aqui o nome da tarefa",
            text: $viewModel.taskName
        )
        .height(48)
    }
    
    // MARK: - Description Field
    private var descriptionField: some View {
        PJTextEditorView(
            title: "Descrição",
            placeholder: "Digite aqui a descrição da tarefa",
            text: $viewModel.taskDescription
        )
        .height(100)
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
        DateTimeSelector(
            isRecorrente: $viewModel.isRecurrent,
            selectedDate: $viewModel.selectedDate,
            selectedMonths: $viewModel.selectedMonths,
            selectedWeekDays: $viewModel.selectedWeekDays
        )
    }
    
    // MARK: - Observation Field
    private var observationField: some View {
        PJTextEditorView(
            title: "Observação",
            placeholder: "Digite aqui a sua observação",
            text: $viewModel.observation
        )
        .height(100)
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
