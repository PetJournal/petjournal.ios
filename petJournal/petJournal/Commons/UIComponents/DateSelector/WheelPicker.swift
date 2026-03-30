import SwiftUI

// MARK: - WheelPicker Component
/// Componente reutilizável de seletor tipo roda com título e range personalizável
struct WheelPicker: View {
    var title: String
    var range: [Int]
    @Binding var selection: Int

    var body: some View {
        VStack {
            pickerTitle
            wheelPickerView
        }
        .frame(maxWidth: 100)
    }
    
    // MARK: - ViewBuilder Components
    
    /// Título do picker (opcional)
    @ViewBuilder
    private var pickerTitle: some View {
        if !title.isEmpty {
            Text(title)
                .font(.headline)
                .padding(.bottom, 8)
        }
    }
    
    /// Componente principal do picker em formato roda
    @ViewBuilder
    private var wheelPickerView: some View {
        Picker(title, selection: $selection) {
            ForEach(range, id: \.self) { value in
                pickerItem(for: value)
            }
        }
        .pickerStyle(.wheel)
        .frame(height: 132)
        .clipped()
    }
    
    // MARK: - Helper Methods
    
    /// Item individual do picker com formatação personalizada
    @ViewBuilder
    private func pickerItem(for value: Int) -> some View {
        Text("\(value)")
            .font(.system(size: 32, weight: .bold, design: .rounded))
            .frame(height: 44)
    }
}
