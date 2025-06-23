import SwiftUI

// MARK: - TaskFrequency Enum
enum TaskFrequency: String, CaseIterable {
    case daily = "Diária"
    case weekly = "Semanal"
    case monthly = "Mensal"
}

// MARK: - View
struct TaskListView: View {
    @State private var selectedFrequency: TaskFrequency = .daily
    @State private var showingAddTask = false
    
    private let frequencies: [TaskFrequency] = TaskFrequency.allCases
    
    private var groupedTasks: [String: [PetTaskModel]] {
        switch selectedFrequency {
        case .daily:
            return [
                "15 de Fev": [PetTaskModel.sampleTasks[0]],
                "16 de Fev": [PetTaskModel.sampleTasks[1]]
            ]
        case .weekly:
            return [
                "Semana 4: 19 de Jan - 25 de Jan": [PetTaskModel.sampleTasks[0]],
                "Semana 5: 26 de Jan - 1 de Fev": [PetTaskModel.sampleTasks[1]]
            ]
        case .monthly:
            return [
                "Janeiro, 2025": [PetTaskModel.sampleTasks[0]],
                "Fevereiro, 2025": [PetTaskModel.sampleTasks[1]]
            ]
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            VStack(alignment: .leading) {
                titleView
                frequencySelectorView
                tasksListView
            }
            
            addTaskButton
        }
        .sheet(isPresented: $showingAddTask) {
            // AddTaskView()
        }
    }
    
    // MARK: Subviews
    
    private var titleView: some View {
        Text("Próximas tarefas")
            .font(.robotoMedium(size: .medium))
            .padding(.horizontal)
            .padding(.top, 20)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var frequencySelectorView: some View {
        HStack(spacing: 0) {
            ForEach(frequencies, id: \.self) { frequency in
                Button(action: {
                    withAnimation(.easeInOut) {
                        selectedFrequency = frequency
                    }
                }) {
                    Text(frequency.rawValue)
                        .font(.robotoMedium(size: .small))
                        .foregroundColor(selectedFrequency == frequency ?
                                         Color.theme.petPrimary500 : .primary)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(Color.clear)
                        .overlay(
                            VStack {
                                if selectedFrequency == frequency {
                                    Rectangle()
                                        .frame(height: 2)
                                        .foregroundColor(Color.theme.petPrimary500)
                                        .padding(.horizontal, 8)
                                }
                            }
                            .frame(maxHeight: .infinity, alignment: .bottom)
                        )
                }
            }
        }
        .padding(.horizontal)
    }
    
    private var tasksListView: some View {
        List {
            ForEach(Array(groupedTasks.keys.sorted()), id: \.self) { sectionTitle in
                Section(header: Text(sectionTitle)
                    .font(.robotoMedium(size: .large))
                    .foregroundColor(Color.theme.petBlack)) {
                        ForEach(groupedTasks[sectionTitle] ?? []) { task in
                            PetTaskCard(presenter: PetTaskCardPresenter(task: task))
                                .listRowInsets(EdgeInsets())
                                .listRowSeparator(.hidden)
                                .padding(.vertical, 8)
                        }
                    }
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var addTaskButton: some View {
        Button(action: {
            showingAddTask = true
        }) {
            Image(systemName: "plus")
                .font(.robotoMedium(size: .biggest))
                .frame(width: 60, height: 60)
                .background(Color.theme.petPrimary500)
                .foregroundColor(.white)
                .clipShape(Circle())
                .shadow(radius: 4)
        }
        .padding()
        .offset(x: -10, y: -10)
    }
    
}

// MARK: - PreviewProvider
struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TaskListView()
        }
    }
}
