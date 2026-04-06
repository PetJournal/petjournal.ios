import SwiftUI

struct FormField<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.robotoMedium(size: .great))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            content
        }
    }
}

struct SelectionField<Content: View>: View {
    let title: String
    let content: Content
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.robotoMedium(size: .great))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            content
        }
    }
}

#Preview("Formulário e Seletor") {
    VStack {
        FormField(title: "Nome do Pet") {
            TextField("O nome do seu Pet", text: .constant("Caramelo"))
        }
        .padding()
        
        SelectionField(title: "Sexo") {
            HStack() {
                PJButton.selection("Macho", isSelected: true) {}
                Spacer()
                PJButton.selection("Fêmea", isSelected: false) {}
            }
        }
        .padding()
    }
}
