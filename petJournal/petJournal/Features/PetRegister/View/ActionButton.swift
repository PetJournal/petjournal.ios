import SwiftUI

struct ActionButton: View {
    let icon: ImageResource
    let background: Color
    let action: () -> Void
    
    init(_ icon: ImageResource, background: Color = .clear, action: @escaping () -> Void) {
        self.icon = icon
        self.background = background
        self.action = action
    }
    
    var body: some View {
        Button(action: action) {
            Image(icon)
                .foregroundStyle(.white)
                .frame(width: 30, height: 30)
                .background(background)
                .cornerRadius(12)
        }
    }
}

// MARK: - Previews
#Preview("Exemplos de uso") {
    VStack {
        ActionButton(.icTrash, action: {})
        ActionButton(.icPencil, 
                     background: .theme.petPrimary500) {}
    }
}

