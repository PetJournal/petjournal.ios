import SwiftUI

/// Creates a custom navigation bar with a back button and a title.
///
/// - Parameters:
///   - title: The title of the navigation bar.
///   - onClick: An action to be executed when the back button is pressed.
///
/// - Returns: A view that represents the custom navigation bar.
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
                .offset(x: -20.0)
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
