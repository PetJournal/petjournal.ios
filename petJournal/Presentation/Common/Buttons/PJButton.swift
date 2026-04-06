import SwiftUI

struct PJButton: View {
    let title: String
    let action: () -> Void
    
    // Customization properties
    var backgroundColor: Color = .theme.petPrimary500
    var foregroundColor: Color = .theme.petWhite
    var font: Font = .robotoSemiBold(size: .small)
    var cornerRadius: CGFloat = 8
    var borderColor: Color = .clear
    var borderWidth: CGFloat = 0
    var width: CGFloat? = nil
    var height: CGFloat = 50
    var shadowColor: Color = .clear
    var shadowRadius: CGFloat = 0
    var shadowOffset: CGSize = .zero
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(font)
                .foregroundColor(foregroundColor)
                .frame(maxWidth: width == nil ? .infinity : width, minHeight: height)
        }
        .background(backgroundColor)
        .cornerRadius(cornerRadius)
        .overlay(
            RoundedRectangle(cornerRadius: cornerRadius)
                .stroke(borderColor, lineWidth: borderWidth)
        )
        .shadow(color: shadowColor, radius: shadowRadius, x: shadowOffset.width, y: shadowOffset.height)
    }
}

// MARK: - Convenience Initializers
extension PJButton {
    // Primary button (default)
    static func primary(_ title: String, action: @escaping () -> Void) -> PJButton {
        PJButton(title: title, action: action)
    }
    
    // Secondary button
    static func secondary(_ title: String, action: @escaping () -> Void) -> PJButton {
        PJButton(title: title, action: action)
            .backgroundColor(.theme.petWhite)
            .foregroundColor(.theme.petPrimary500)
            .borderColor(.gray)
            .borderWidth(1)
    }
    
    // Selection button style
    static func selection(_ title: String, isSelected: Bool, action: @escaping () -> Void) -> PJButton {
        PJButton(title: title, action: action)
            .backgroundColor(isSelected ? .theme.petPrimary500 : .theme.petWhite)
            .foregroundColor(isSelected ? .theme.petWhite : .theme.petPrimary500)
            .borderColor(isSelected ? .clear : .gray)
            .borderWidth(isSelected ? 0 : 1)
            .cornerRadius(50)
            .width(121)
            .height(40)
            .shadowColor(isSelected ? .black.opacity(0.25) : .clear)
            .shadowRadius(10)
            .shadowOffset(CGSize(width: 3, height: 4))
    }
    
    // Save button style (like PrimaryButtonStyle)
    static func save(_ title: String, action: @escaping () -> Void) -> PJButton {
        PJButton(title: title, action: action)
            .backgroundColor(.theme.petWhite)
            .foregroundColor(.theme.petPrimary500)
            .borderColor(.gray)
            .borderWidth(1)
            .cornerRadius(50)
            .width(121)
            .height(40)
            .shadowColor(.black.opacity(0.25))
            .shadowRadius(10)
            .shadowOffset(CGSize(width: 3, height: 4))
    }
}

// MARK: - Modifier Methods
extension PJButton {
    func backgroundColor(_ color: Color) -> PJButton {
        var button = self
        button.backgroundColor = color
        return button
    }
    
    func foregroundColor(_ color: Color) -> PJButton {
        var button = self
        button.foregroundColor = color
        return button
    }
    
    func font(_ font: Font) -> PJButton {
        var button = self
        button.font = font
        return button
    }
    
    func cornerRadius(_ radius: CGFloat) -> PJButton {
        var button = self
        button.cornerRadius = radius
        return button
    }
    
    func borderColor(_ color: Color) -> PJButton {
        var button = self
        button.borderColor = color
        return button
    }
    
    func borderWidth(_ width: CGFloat) -> PJButton {
        var button = self
        button.borderWidth = width
        return button
    }
    
    func width(_ width: CGFloat) -> PJButton {
        var button = self
        button.width = width
        return button
    }
    
    func height(_ height: CGFloat) -> PJButton {
        var button = self
        button.height = height
        return button
    }
    
    func shadowColor(_ color: Color) -> PJButton {
        var button = self
        button.shadowColor = color
        return button
    }
    
    func shadowRadius(_ radius: CGFloat) -> PJButton {
        var button = self
        button.shadowRadius = radius
        return button
    }
    
    func shadowOffset(_ offset: CGSize) -> PJButton {
        var button = self
        button.shadowOffset = offset
        return button
    }
}

#Preview {
    VStack(spacing: 20) {
        PJButton.primary("Primário") {}
        PJButton.secondary("Secundário") {}
        PJButton.selection("Selecionado", isSelected: true) {}
        PJButton.selection("Não Selecionado", isSelected: false) {}
        PJButton.save("Salvar") {}
        
        // Custom button
        PJButton(title: "Custom") {}
            .backgroundColor(.red)
            .foregroundColor(.white)
            .cornerRadius(20)
            .width(200)
    }
    .padding()
}
