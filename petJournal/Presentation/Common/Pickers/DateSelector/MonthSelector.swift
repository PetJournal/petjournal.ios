import SwiftUI

// MARK: - MonthSelector Component
/// Componente para seleção de mêses em layout de grade
struct MonthSelector: View {
    @Binding var selectedMonths: Set<Int>

    // MARK: - Constants
    private let months = [
        ("Jan", 1), ("Fev", 2), ("Mar", 3), ("Abr", 4),
        ("Mai", 5), ("Jun", 6), ("Jul", 7), ("Ago", 8),
        ("Set", 9), ("Out", 10), ("Nov", 11), ("Dez", 12)
    ]

    var body: some View {
        VStack(spacing: 12) {
            monthsTitle
            monthsGrid
        }
        .padding(.horizontal, 24)
    }
    
    // MARK: - ViewBuilder Components
    
    /// Título da seção de meses
    @ViewBuilder
    private var monthsTitle: some View {
        Text("Ativo nos meses")
            .font(.subheadline)
            .foregroundColor(.black)
    }
    
    /// Grade de botões dos meses organizados em layout responsivo
    @ViewBuilder
    private var monthsGrid: some View {
        GeometryReader { geometry in
            let totalSpacing: CGFloat = 8 * 3 // 4 colunas = 3 espaços
            let buttonWidth = (geometry.size.width - totalSpacing) / 4

            VStack(spacing: 12) {
                firstRowMonths(buttonWidth: buttonWidth)
                secondRowMonths(buttonWidth: buttonWidth)
                thirdRowMonths(buttonWidth: buttonWidth)
            }
            .frame(maxWidth: .infinity)
        }
        .frame(height: 3 * (36 + 12)) // altura aproximada para 3 linhas
    }
    
    /// Primeira linha de meses (Jan-Abr)
    @ViewBuilder
    private func firstRowMonths(buttonWidth: CGFloat) -> some View {
        HStack(spacing: 8) {
            ForEach(months[0..<4], id: \.1) { month in
                monthButton(for: month, width: buttonWidth)
            }
        }
    }
    
    /// Segunda linha de meses (Mai-Ago)
    @ViewBuilder
    private func secondRowMonths(buttonWidth: CGFloat) -> some View {
        HStack(spacing: 8) {
            ForEach(months[4..<8], id: \.1) { month in
                monthButton(for: month, width: buttonWidth)
            }
        }
    }
    
    /// Terceira linha de meses (Set-Out, Nov-Dez centralizados)
    @ViewBuilder
    private func thirdRowMonths(buttonWidth: CGFloat) -> some View {
        HStack(spacing: 8) {
            ForEach(months[8..<10], id: \.1) { month in
                monthButton(for: month, width: buttonWidth)
            }
            Spacer(minLength: 0)
            ForEach(months[10..<12], id: \.1) { month in
                monthButton(for: month, width: buttonWidth)
            }
        }
    }
    
    // MARK: - Helper Methods
    
    /// Cria um botão para seleção de mês
    @ViewBuilder
    private func monthButton(for month: (String, Int), width: CGFloat) -> some View {
        Button(action: {
            toggleMonth(month.1)
        }) {
            Text(month.0)
                .font(.subheadline)
                .frame(width: width, height: 36)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(selectedMonths.contains(month.1) ? Color.orange : Color.purple)
                )
                .foregroundColor(.white)
        }
    }
    
    // MARK: - Private Methods
    
    /// Alterna a seleção de um mês
    private func toggleMonth(_ month: Int) {
        if selectedMonths.contains(month) {
            selectedMonths.remove(month)
        } else {
            selectedMonths.insert(month)
        }
    }
}
