import SwiftUI

extension TextField {
    func textFieldStyle() -> some View {
        self
            .frame(maxWidth: .infinity, maxHeight: 50, alignment: .leading)
            .padding(.leading)
            .padding(.vertical, 10)
            .background(Color.theme.petWhite)
            .overlay(
                RoundedRectangle(cornerRadius: 14)
                    .stroke(Color.theme.petGray800.opacity(0.6), lineWidth: 1)
            )
            .shadow(color: Color.theme.petPrimary500.opacity(0.2), radius: 10)
    }
}
