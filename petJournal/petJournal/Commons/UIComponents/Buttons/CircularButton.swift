import SwiftUI

struct CircularButton: View {
    let size: CGFloat
    let action: () -> Void
    let iconName: String
    let backgroundColor: Color
    let foregroundColor: Color
    let font: Font
    
    init(
        size: CGFloat = 60,
        iconName: String = "plus",
        backgroundColor: Color = Color.theme.petPrimary500,
        foregroundColor: Color = Color.theme.petWhite,
        font: Font = .robotoMedium(size: .great),
        action: @escaping () -> Void
    ) {
        self.size = size
        self.iconName = iconName
        self.backgroundColor = backgroundColor
        self.foregroundColor = foregroundColor
        self.action = action
        self.font = font
    }
    
    var body: some View {
        Button(action: action) {
            Image(systemName: iconName)
                .font(font)
                .frame(width: size, height: size)
                .background(backgroundColor)
                .foregroundColor(foregroundColor)
                .clipShape(Circle())
                .shadow(radius: 4)
        }
    }
}

struct CircularButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 30) {
            // 1. Botão padrão (como o original)
            CircularButton(action: {})
            
            // 2. Botão maior
            CircularButton(
                size: 80,
                font: .robotoLight(size: .biggest), 
                action: {}
            )
            
            // 3. Botão com ícone diferente
            CircularButton(
                iconName: "minus",
                action: {}
            )
            
            // 4. Botão com cores personalizadas
            CircularButton(
                backgroundColor: Color.theme.petCerise,
                foregroundColor: Color.theme.petPrimary100,
                action: {}
            )
            
            // 5. Botão pequeno
            CircularButton(
                size: 40,
                iconName: "checkmark",
                backgroundColor: Color.theme.petGreen,
                action: {}
            )
            
            // 6. Botão com estilo alternativo
            CircularButton(
                size: 70,
                iconName: "star.fill",
                backgroundColor: .orange,
                foregroundColor: .black,
                action: {}
            )
        }
        .previewDisplayName("Botões Personalizados")
    }
}
