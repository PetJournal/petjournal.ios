import SwiftUI

// MARK: - WeekSelector Component
/// Componente para seleção de dias da semana em layout vertical
struct WeekSelector: View {
    @Binding var selectedWeekDays: Set<Int>
    
    // MARK: - Constants
    private let weekDays = [
        ("Dom", 1), ("Seg", 2), ("Ter", 3),
        ("Qua", 4), ("Qui", 5), ("Sex", 6),
        ("Sab", 7)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            weekDaysGrid
            lastDayButton
        }
        .frame(width: 140)
    }
    
    // MARK: - ViewBuilder Components
    
    /// Grade dos primeiros 6 dias da semana (2 colunas)
    @ViewBuilder
    private var weekDaysGrid: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 12), count: 2), spacing: 12) {
            ForEach(0..<6) { index in
                dayButton(for: weekDays[index])
            }
        }
    }
    
    /// Botão do último dia (Sábado) centralizado
    @ViewBuilder
    private var lastDayButton: some View {
        dayButton(for: weekDays[6])
            .frame(maxWidth: .infinity)
    }
    
    // MARK: - Helper Methods
    
    /// Cria um botão para seleção de dia da semana
    @ViewBuilder
    private func dayButton(for day: (String, Int)) -> some View {
        Button(action: {
            toggleWeekDay(day.1)
        }) {
            Text(day.0)
                .font(.subheadline)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .frame(maxWidth: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.purple, lineWidth: 1)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(selectedWeekDays.contains(day.1) ? Color.purple.opacity(0.2) : Color.clear)
                        )
                )
                .foregroundColor(selectedWeekDays.contains(day.1) ? .purple : .gray)
        }
    }
    
    // MARK: - Private Methods
    
    /// Alterna a seleção de um dia da semana
    private func toggleWeekDay(_ day: Int) {
        if selectedWeekDays.contains(day) {
            selectedWeekDays.remove(day)
        } else {
            selectedWeekDays.insert(day)
        }
    }
}



#Preview {
    struct WeekSelectorPreviewWrapper: View {
        @State private var selectedDays: Set<Int> = []

        var body: some View {
            WeekSelector(selectedWeekDays: $selectedDays)
                .padding()
        }
    }

    return WeekSelectorPreviewWrapper()
}
