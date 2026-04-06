import SwiftUI

// MARK: - HourSelector Component
/// Componente para seleção de horário com formato 12h (AM/PM)
struct HourSelector: View {
    @Binding var selectedHour: Date
    @Binding var showTimePicker: Bool

    @State private var hour: Int = 12
    @State private var minute: Int = 0
    @State private var isAM: Bool = true

    var body: some View {
        VStack(spacing: 16) {
            hourTitle
            hourPickerContainer
        }
        .onAppear { initializeFromDate() }
        .onChange(of: hour) { _ in updateDate() }
        .onChange(of: minute) { _ in updateDate() }
    }
    
    // MARK: - ViewBuilder Components
    
    /// Título centralizado do seletor de hora
    @ViewBuilder
    private var hourTitle: some View {
        Text("Hora")
            .font(.headline)
            .frame(maxWidth: .infinity)
            .multilineTextAlignment(.center)
    }
    
    /// Container principal dos seletores de hora
    @ViewBuilder
    private var hourPickerContainer: some View {
        HStack(spacing: 8) {
            amPmSelector
            hourWheelPicker
            timeSeparator
            minuteWheelPicker
        }
        .frame(height: 150)
    }
    
    /// Seletor AM/PM customizado
    @ViewBuilder
    private var amPmSelector: some View {
        VStack(spacing: 0) {
            amPmButton(title: "AM", isSelected: isAM) {
                updateAMPM(isPM: false)
            }
            
            Divider()
                .background(Color.purple)
            
            amPmButton(title: "PM", isSelected: !isAM) {
                updateAMPM(isPM: true)
            }
        }
        .frame(width: 30, height: 60)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.purple, lineWidth: 1)
        )
        .fixedSize()
        .padding(.trailing, 8)
    }
    
    /// Seletor de hora (1-12)
    @ViewBuilder
    private var hourWheelPicker: some View {
        WheelPicker(title: "", range: Array(1...12), selection: $hour)
    }
    
    /// Separador visual entre hora e minuto
    @ViewBuilder
    private var timeSeparator: some View {
        Text(":")
            .font(.title2)
            .padding(.bottom, 40)
    }
    
    /// Seletor de minuto (0-59)
    @ViewBuilder
    private var minuteWheelPicker: some View {
        WheelPicker(title: "", range: Array(0...59), selection: $minute)
    }
    
    // MARK: - Helper Methods
    
    /// Cria um botão AM/PM
    @ViewBuilder
    private func amPmButton(title: String, isSelected: Bool, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(isSelected ? Color.purple.opacity(0.2) : Color.clear)
                )
                .foregroundColor(isSelected ? .purple : .gray)
        }
    }
    
    // MARK: - Private Methods
    
    /// Inicializa os valores baseado na data selecionada
    private func initializeFromDate() {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: selectedHour)
        let h = components.hour ?? 0
        hour = h == 0 ? 12 : (h > 12 ? h - 12 : h)
        isAM = h < 12
        minute = components.minute ?? 0
    }
    
    /// Atualiza o período AM/PM
    private func updateAMPM(isPM: Bool) {
        isAM = !isPM
        updateDate()
    }
    
    /// Atualiza a data com os valores selecionados
    private func updateDate() {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current

        var components = calendar.dateComponents([.year, .month, .day], from: selectedHour)

        var h = hour % 12
        if !isAM { h += 12 }
        if isAM && hour == 12 { h = 0 }

        components.hour = h
        components.minute = minute

        if let newDate = calendar.date(from: components) {
            selectedHour = newDate
        }
    }
}


#Preview {
    struct HourSelectorPreviewWrapper: View {
        @State private var selectedDate = Date()
        @State private var showTimePicker = false

        var body: some View {
            HourSelector(selectedHour: $selectedDate, showTimePicker: $showTimePicker)
                .padding()
        }
    }

    return HourSelectorPreviewWrapper()
}
