import SwiftUI

// MARK: - Enums
enum TaskFrequency: String, CaseIterable {
    case daily = "Diária"
    case weekly = "Semanal"
    case monthly = "Mensal"
}

enum TaskType: String, CaseIterable, Hashable {
    case vaccine = "Vacina"
    case medicine = "Medicamento"
    case consultation = "Consulta"
    case all = "Todos"
}

// MARK: - View
struct TaskListView: View {
    @EnvironmentObject var router: NavigationRouter
    @StateObject private var viewModel: TaskListViewModel
    @State private var selectedFrequency: TaskFrequency = .daily
    @State private var showingAddTask = false
    
    init(filterType: TaskType = .all, service: TaskServiceProtocol = TaskService()) {
        self._viewModel = StateObject(wrappedValue: TaskListViewModel(service: service, filterType: filterType))
    }
    
    private var groupedTasks: [String: [PetTaskModel]] {
        viewModel.groupedTasks(by: selectedFrequency)
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
            CircularButton(font: .robotoMedium(size: .biggest),
                           action: { showingAddTask = true })
            .padding()
            .offset(x: -10, y: -10)
        }
        .task {
            await viewModel.fetchTasks()
            await viewModel.fetchHistoricTasks()
        }
        .navigationDestination(for: Route.self) { route in
            switch route {
            case .petProfile(let pet):
                PetProfileView(pet: pet)
            default:
                EmptyView()
            }
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
        switch viewModel.filterType {
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
            
            Section(header: historicHeader) {
                ForEach(viewModel.historicTasks) { task in
                    PetTaskCard(presenter: PetTaskCardPresenter(task: task))
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                        .padding(.vertical, 8)
                }
            }
        }
        .listStyle(PlainListStyle())
        .refreshable {
            await viewModel.fetchTasks()
            await viewModel.fetchHistoricTasks()
        }
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

// MARK: - Previews
#Preview {
    TaskListView(filterType: .all, service: TaskService.mock())
}

#Preview("Filtro por vacina") {
    TaskListView(filterType: .vaccine, service: TaskService.mock())
}
