import SwiftUI

/// Cria uma barra de navega o personalizada com um bot o de voltar e um t tulo.
///
/// - Parameters:
///   - title: O t tulo da barra de navega o.
///   - onClick: Uma a o a ser executada quando o bot o de voltar for pressionado.
///
/// - Returns: Uma view que representa a barra de navega o personalizada.
extension View {
    func customNavigationBar(title: String, onClick: @escaping (() -> Void) = {}) -> some View {
        return HStack {
            Button {
                onClick()
            } label: {
                Image(systemName: "chevron.backward")
            }
            Spacer()
            Text(title)
            Spacer()
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: 50)
            .padding(.leading)
    }
}

struct CustomNavigationBarPreview: View {
    var body: some View {
        customNavigationBar(title: "Editar dados do Pet")
    }
}

#Preview {
    CustomNavigationBarPreview()
}
