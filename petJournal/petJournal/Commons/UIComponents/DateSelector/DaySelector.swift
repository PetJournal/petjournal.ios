import SwiftUI

// MARK: - DaySelector Component
/// Componente para seleção de dia do mês usando WheelPicker
struct DaySelector: View {
    @Binding var selectedDay: Int
    var maxDay: Int
    
    var body: some View {
        dayWheelPicker
    }
    
    // MARK: - ViewBuilder Components
    
    /// Seletor de dia com validação do máximo de dias do mês
    @ViewBuilder
    private var dayWheelPicker: some View {
        WheelPicker(
            title: "DIA", 
            range: Array(1...maxDay), 
            selection: $selectedDay
        )
    }
}
