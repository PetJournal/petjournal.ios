import SwiftUI

struct PJTextEditorView: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    
    // Customization properties
    var height: CGFloat = 100
    var minHeight: CGFloat = 40
    var titleFont: Font = .robotoMedium(size: .small)
    var titleColor: Color = .theme.petBlack
    var placeholderFont: Font = .robotoMedium(size: .small)
    var placeholderColor: Color = .theme.petGray300
    var borderColor: Color = .theme.petGray800
    var borderWidth: CGFloat = 1
    var cornerRadius: CGFloat = 10
    var backgroundColor: Color = .theme.petWhite
    var shadowColor: Color = .theme.petBlack.opacity(0.25)
    var shadowRadius: CGFloat = 10
    var shadowOffset: CGSize = CGSize(width: 3, height: 4)
    var spacing: CGFloat = 14
    
    var body: some View {
        VStack(alignment: .leading, spacing: spacing) {
            Text(title)
                .font(titleFont)
                .foregroundColor(titleColor)
            
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .fill(backgroundColor)
                    .shadow(color: shadowColor, radius: shadowRadius, x: shadowOffset.width, y: shadowOffset.height)
                
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(borderColor, lineWidth: borderWidth)
                
                TextEditor(text: $text)
                    .frame(height: max(height, minHeight))
                    .padding(8)
                    .background(Color.clear)
                
                if text.isEmpty {
                    VStack {
                        HStack {
                            Text(placeholder)
                                .foregroundColor(placeholderColor)
                                .font(placeholderFont)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 16)
                            Spacer()
                        }
                        Spacer()
                    }
                    .allowsHitTesting(false)
                }
            }
            .frame(height: max(height, minHeight))
        }
    }
}

// MARK: - Modifier Methods
extension PJTextEditorView {
    func height(_ height: CGFloat) -> PJTextEditorView {
        var view = self
        view.height = height
        return view
    }
    
    func minHeight(_ minHeight: CGFloat) -> PJTextEditorView {
        var view = self
        view.minHeight = minHeight
        return view
    }
    
    func titleFont(_ font: Font) -> PJTextEditorView {
        var view = self
        view.titleFont = font
        return view
    }
    
    func titleColor(_ color: Color) -> PJTextEditorView {
        var view = self
        view.titleColor = color
        return view
    }
    
    func placeholderFont(_ font: Font) -> PJTextEditorView {
        var view = self
        view.placeholderFont = font
        return view
    }
    
    func placeholderColor(_ color: Color) -> PJTextEditorView {
        var view = self
        view.placeholderColor = color
        return view
    }
    
    func borderColor(_ color: Color) -> PJTextEditorView {
        var view = self
        view.borderColor = color
        return view
    }
    
    func borderWidth(_ width: CGFloat) -> PJTextEditorView {
        var view = self
        view.borderWidth = width
        return view
    }
    
    func cornerRadius(_ radius: CGFloat) -> PJTextEditorView {
        var view = self
        view.cornerRadius = radius
        return view
    }
    
    func backgroundColor(_ color: Color) -> PJTextEditorView {
        var view = self
        view.backgroundColor = color
        return view
    }
    
    func shadowColor(_ color: Color) -> PJTextEditorView {
        var view = self
        view.shadowColor = color
        return view
    }
    
    func shadowRadius(_ radius: CGFloat) -> PJTextEditorView {
        var view = self
        view.shadowRadius = radius
        return view
    }
    
    func shadowOffset(_ offset: CGSize) -> PJTextEditorView {
        var view = self
        view.shadowOffset = offset
        return view
    }
    
    func spacing(_ spacing: CGFloat) -> PJTextEditorView {
        var view = self
        view.spacing = spacing
        return view
    }
}

#Preview {
    VStack(spacing: 40) {
        PJTextEditorView(
            title: "Nome da tarefa",
            placeholder: "Digite aqui o nome da tarefa",
            text: .constant("")
        )
        .height(10)
        
        PJTextEditorView(
            title: "Descrição",
            placeholder: "Digite aqui a descrição",
            text: .constant("Texto de exemplo")
        )
        .height(100)
        
        PJTextEditorView(
            title: "Custom",
            placeholder: "Campo customizado",
            text: .constant("")
        )
        .height(80)
        .borderColor(.blue)
        .borderWidth(2)
        .cornerRadius(15)
        .shadowColor(.blue.opacity(0.3))
    }
    .padding()
}
