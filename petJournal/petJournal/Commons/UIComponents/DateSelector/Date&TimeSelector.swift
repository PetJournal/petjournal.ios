import SwiftUI

// MARK: - Frequency Type
enum Frequency: String, CaseIterable {
    case daily = "Diária"
    case weekly = "Semanal"
    case monthly = "Mensal"
}

// MARK: - Main DateTimeSelector View
struct DateTimeSelector: View {
    @State private var isRecorrente = true
    @State private var selectedFrequency: Frequency = .daily
    @State var selectedDate = Date()
    @State private var showTimePicker = false
    @State private var showDatePicker = false
    @State var selectedMonths: Set<Int> = []
    @State var selectedWeekDays: Set<Int> = []
    
    // MARK: - Formatters
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }()
    
    // MARK: - Computed Properties
    /// Retorna "Hoje" se for a data atual, senão retorna a data formatada
    private var displayDate: String {
        let date = dateFormatter.string(from: selectedDate)
        return date == dateFormatter.string(from: Date()) ? "Hoje" : date
    }
    
    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            recurrenceTypeSelector
            
            if isRecorrente {
                frequencySelector
                frequencyContentView
            } else {
                punctualDateSelector
                HourSelector(selectedHour: $selectedDate, showTimePicker: $showTimePicker)
            }
        }
        .sheet(isPresented: $showDatePicker) {
            LegacyDatePickerSheet(selectedDate: $selectedDate)
        }
    }
    
    // MARK: - ViewBuilder Components
    
    /// Seletor entre modo Recorrente e Pontual
    @ViewBuilder
    private var recurrenceTypeSelector: some View {
        HStack(spacing: 12) {
            recurrenceButton(title: "Recorrente", isSelected: isRecorrente) {
                isRecorrente = true
            }
            
            recurrenceButton(title: "Pontual", isSelected: !isRecorrente) {
                isRecorrente = false
            }
        }
    }
    
    /// Seletor de frequência (Diária, Semanal, Mensal)
    @ViewBuilder
    private var frequencySelector: some View {
        HStack(spacing: 20) {
            ForEach(Frequency.allCases, id: \.self) { frequency in
                frequencyButton(for: frequency)
            }
        }
    }
    
    /// Conteúdo específico baseado na frequência selecionada
    @ViewBuilder
    private var frequencyContentView: some View {
        switch selectedFrequency {
        case .monthly:
            monthlyFrequencyView
        case .weekly:
            weeklyFrequencyView
        default:
            HourSelector(selectedHour: $selectedDate, showTimePicker: $showTimePicker)
        }
    }
    
    /// Layout para frequência mensal (dia + hora + meses)
    @ViewBuilder
    private var monthlyFrequencyView: some View {
        HStack {
            DaySelector(
                selectedDay: dayBinding,
                maxDay: numberOfDays(in: selectedDate)
            )
            
            HourSelector(selectedHour: $selectedDate, showTimePicker: $showTimePicker)
        }
        
        MonthSelector(selectedMonths: $selectedMonths)
            .padding(.horizontal, 47)
    }
    
    /// Layout para frequência semanal (dias da semana + hora)
    @ViewBuilder
    private var weeklyFrequencyView: some View {
        HStack(alignment: .center, spacing: 16) {
            WeekSelector(selectedWeekDays: $selectedWeekDays)
            
            HourSelector(
                selectedHour: $selectedDate,
                showTimePicker: $showTimePicker
            )
        }
        .padding(.horizontal)
    }
    
    /// Seletor de data para modo pontual
    @ViewBuilder
    private var punctualDateSelector: some View {
        Button(action: { showDatePicker.toggle() }) {
            HStack {
                Text(displayDate)
                    .foregroundColor(.black)
                
                Spacer()
                
                Image(systemName: "calendar")
                    .foregroundColor(.purple)
                    .padding(8)
                    .background(
                        Circle()
                            .fill(Color.purple.opacity(0.1))
                    )
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.purple.opacity(0.5), lineWidth: 1)
            )
        }
        .padding(.horizontal, 24)
    }
    
    // MARK: - Helper Methods
    
    /// Cria um botão para seleção de tipo de recorrência
    @ViewBuilder
    private func recurrenceButton(title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(
                    Capsule()
                        .fill(isSelected ? Color.purple.opacity(0.2) : Color.clear)
                )
                .foregroundColor(isSelected ? .purple : .gray)
        }
    }
    
    /// Cria um botão para seleção de frequência
    @ViewBuilder
    private func frequencyButton(for frequency: Frequency) -> some View {
        Button(action: {
            selectedFrequency = frequency
            initializeFrequencyDefaults(for: frequency)
        }) {
            Text(frequency.rawValue)
                .foregroundColor(selectedFrequency == frequency ? .purple : .gray)
                .padding(.bottom, 8)
                .overlay(
                    Rectangle()
                        .frame(height: 2)
                        .foregroundColor(selectedFrequency == frequency ? .purple : .clear)
                        .offset(y: 4)
                )
        }
    }
    
    // MARK: - Computed Bindings
    
    /// Binding para o dia selecionado com validação de limite do mês
    private var dayBinding: Binding<Int> {
        Binding(
            get: {
                Calendar.current.component(.day, from: selectedDate)
            },
            set: { newDay in
                var components = Calendar.current.dateComponents([.year, .month, .hour, .minute], from: selectedDate)
                components.day = min(newDay, numberOfDays(in: selectedDate))
                if let newDate = Calendar.current.date(from: components) {
                    selectedDate = newDate
                }
            }
        )
    }
    
    // MARK: - Private Methods
    
    /// Inicializa valores padrão quando uma frequência é selecionada
    private func initializeFrequencyDefaults(for frequency: Frequency) {
        switch frequency {
        case .monthly:
            if selectedMonths.isEmpty {
                let currentMonth = Calendar.current.component(.month, from: Date())
                selectedMonths.insert(currentMonth)
            }
        case .weekly:
            if selectedWeekDays.isEmpty {
                let currentWeekDay = Calendar.current.component(.weekday, from: Date())
                selectedWeekDays.insert(currentWeekDay)
            }
        case .daily:
            break
        }
    }
    
    /// Retorna o número de dias no mês da data fornecida
    private func numberOfDays(in date: Date) -> Int {
        let calendar = Calendar.current
        let range = calendar.range(of: .day, in: .month, for: date)
        return range?.count ?? 30
    }
}

// Date Picker Sheet com implementação legacy
struct LegacyDatePickerSheet: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var selectedDate: Date
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Barra de navegação personalizada
                HStack {
                    Spacer()
                    Button("Pronto") {
                        dismiss()
                    }
                    .foregroundColor(.purple)
                }
                .padding()
                .background(Color(UIColor.systemBackground))
                
                // Date Picker
                DatePicker("Selecione a data",
                           selection: $selectedDate,
                           displayedComponents: .date)
                .datePickerStyle(.graphical)
                .labelsHidden()
                .padding()
                
                Spacer()
            }
            .background(Color(UIColor.systemBackground))
        }
        .frame(maxHeight: 400)
    }
}

// Preview
#Preview {
    DateTimeSelector()
}
