import SwiftUI

// MARK: - Enums
enum TaskFrequency: String, CaseIterable {
    case daily = "Diária"
    case weekly = "Semanal"
    case monthly = "Mensal"
}

enum TaskType: String, CaseIterable {
    case vaccine = "Vacina"
    case medicine = "Medicamento"
    case consultation = "Consulta"
    case all = "Todos"
}

// MARK: - View
struct TaskListView: View {
    @State private var selectedFrequency: TaskFrequency = .daily
    @State private var showingAddTask = false
    private let filterType: TaskType
    private let tasks: [PetTaskModel]
    
    init(tasks: [PetTaskModel], filterType: TaskType = .all) {
        self.tasks = tasks
        self.filterType = filterType
    }
    
    private var filteredTasks: [PetTaskModel] {
        filterType == .all ? tasks : tasks.filter { $0.taskType == filterType }
    }
    
    private var groupedTasks: [String: [PetTaskModel]] {
        let groupingKey: (PetTaskModel) -> String = {
            switch selectedFrequency {
            case .daily: return $0.startAt.toISOFormat()
            case .weekly: return $0.startAt.toISOWeekFormat()
            case .monthly: return $0.startAt.toISOMonthFormat()
            }
        }
        return Dictionary(grouping: filteredTasks, by: groupingKey)
    }
    
    private var pastTasks: [PetTaskModel] {
        let currentDate = Date()
        return filteredTasks.filter { $0.startAt.toDate() ?? Date() < currentDate }
    }
    
    private func formatSectionTitle(_ key: String) -> String {
            switch selectedFrequency {
            case .daily:
                return key.toDayMonthFormat
            case .weekly:
                return key.toWeekRangeFormat
            case .monthly:
                return key.toMonthYearFormat
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
            // CreateTaskView()
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
            ForEach(TaskFrequency.allCases, id: \.self) { frequency in
                FrequencyButton(
                    frequency: frequency,
                    isSelected: frequency == selectedFrequency,
                    action: { selectedFrequency = frequency }
                )
            }
        }
        .padding(.horizontal)
    }
    
    private var historicHeader: some View {
        Text(historicHeaderTitle)
            .font(.robotoMedium(size: .large))
            .foregroundColor(Color.theme.petBlack)
    }
    
    private var historicHeaderTitle: String {
        switch filterType {
        case .vaccine:
            return "Histórico de vacinas"
        case .medicine:
            return "Histórico de medicamentos"
        case .consultation:
            return "Histórico de consultas"
        case .all:
            return "Histórico"
        }
    }
    
    private var tasksListView: some View {
        List {
            ForEach(Array(groupedTasks.keys.sorted()), id: \.self) { key in
                TaskSection(key: key, tasks: groupedTasks[key] ?? [],
                            frequency: selectedFrequency)
            }
            
            PJButton(title: "Adicionar tarefa", buttonType: .primaryType) {
                showingAddTask = true
            }
            .padding(.horizontal, UIScreen.main.bounds.width / 4)
            
            Section(header: historicHeader) {
                ForEach(PetTaskModel.sampleHistoricTasks) { task in
                    PetTaskCard(presenter: PetTaskCardPresenter(task: task))
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                        .padding(.vertical, 8)
                }
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var addTaskButton: some View {
        Button(action: { showingAddTask = true }) {
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

// MARK: - Subcomponents
private struct FrequencyButton: View {
    let frequency: TaskFrequency
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(frequency.rawValue)
                .font(.robotoMedium(size: .small))
                .foregroundColor(isSelected ? Color.theme.petPrimary500 : .primary)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 12)
                .background(Color.clear)
                .overlay(selectionIndicator)
        }
    }
    
    private var selectionIndicator: some View {
        VStack {
            if isSelected {
                Rectangle()
                    .frame(height: 2)
                    .foregroundColor(Color.theme.petPrimary500)
                    .padding(.horizontal, 8)
            }
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
    }
}

private struct TaskSection: View {
    let key: String
    let tasks: [PetTaskModel]
    let frequency: TaskFrequency
    
    var body: some View {
        Section(header: sectionHeader) {
            ForEach(tasks) { task in
                PetTaskCard(presenter: PetTaskCardPresenter(task: task))
                    .listRowInsets(EdgeInsets())
                    .listRowSeparator(.hidden)
                    .padding(.vertical, 8)
            }
        }
    }
    
    
    private var sectionHeader: some View {
        Text(formatSectionTitle(key))
            .font(.robotoMedium(size: .large))
            .foregroundColor(Color.theme.petBlack)
    }
    
    private func formatSectionTitle(_ key: String) -> String {
        switch frequency {
        case .daily:
            return key.toDayMonthFormat
        case .weekly:
            return key.toWeekRangeFormat
        case .monthly:
            return key.toMonthYearFormat
        }
    }
}

// MARK: - PreviewProvider
struct TaskListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TaskListView(tasks: PetTaskModel.sampleTasks,
                         filterType: .all)
        }
        NavigationView {
            TaskListView(tasks: PetTaskModel.sampleTasks,
                         filterType: .vaccine)
        }
    }
}
