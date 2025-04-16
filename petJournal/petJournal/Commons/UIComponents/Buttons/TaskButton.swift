import SwiftUI

struct TaskButton: View {
    let title: String
    let primaryColor: Color
    @Binding var isSelected: Bool
    
    var body: some View {
        Button(action: { isSelected.toggle()} ) {
            Text(title)
                .font(.robotoMedium(size: .small))
                .fixedSize(horizontal: true, vertical: false)
                .multilineTextAlignment(.center)
                .padding(10)
                .frame(maxWidth: .infinity, minHeight: 32)
                .foregroundColor(isSelected ? Color.theme.petWhite : primaryColor)
                .background(isSelected ? primaryColor : Color.theme.petWhite)
                .cornerRadius(16)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(isSelected ? primaryColor : Color.theme.petGray800, lineWidth: 1)
                )
                .shadow(
                    color: isSelected ? Color.theme.petGray800.opacity(0.5) : .clear,
                    radius: isSelected ? 6 : 0,
                    x: 0,
                    y: isSelected ? 4 : 0
                )
                .animation(.easeInOut(duration: 0.2), value: isSelected)
        }
    }
}

//MARK: - Usage Example
struct SelectableButtonGroup: View {
    
    @State private var selectedIndex: Int?
    let buttonsData: [(title: String, color: Color)] = [
        (title: "Vacina", color: Color.theme.petOrange),
        (title: "Consulta", color: Color.theme.petGreen),
        (title: "Medicamento", color: Color.theme.petSecondary500),
        (title: "Banho", color: Color.theme.petCerise),
        (title: "Ração", color: Color.theme.petCarnation)]
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(0..<buttonsData.count, id: \.self) { index in
                TaskButton(
                    title: buttonsData[index].title,
                    primaryColor: buttonsData[index].color,
                    isSelected: Binding(
                        get: { selectedIndex == index },
                        set: { isSelected in
                            if isSelected {
                                selectedIndex = index
                            } else if selectedIndex == index {
                                selectedIndex = nil
                            }
                        }
                    )
                )
            }
        }
        .padding()
    }
}

#Preview {
    SelectableButtonGroup()
}
