import SwiftUI

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
