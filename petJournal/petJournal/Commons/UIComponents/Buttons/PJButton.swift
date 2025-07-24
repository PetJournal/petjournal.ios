import SwiftUI

enum ButtonType {
    case primaryType
    case secundaryType
}

struct PJButton: View {
    @State var buttonType: ButtonType = .primaryType
    private let title: String
    private let action: () -> Void
    private let titleFont: Font = .robotoSemiBold(size: .small)
    
    init(title: String,
         buttonType: ButtonType,
         action: @escaping () -> Void) {
        self.title = title
        self.action = action
        _buttonType = State(initialValue: buttonType)
    }
    
    var body: some View {
        HStack {
            Button(action:self.action) {
                Text(self.title)
                    .font(titleFont)
                    .frame(maxWidth:.infinity)
            }
            .buttonStyle(CustomButtonStyle(backgroundColor: buttonType == .primaryType ? Color.theme.petPrimary500 : Color.theme.petWhite,
                                           foregroundColor: buttonType == .primaryType ? Color.theme.petWhite : Color.theme.petPrimary500))
        }
        .frame(maxWidth:.infinity)
    }
}

struct PJButton_Previews: PreviewProvider {
    static var previews: some View {
            VStack(spacing: 20) {
                PJButton(title: "Primário",
                         buttonType: .primaryType,
                         action: {})
                PJButton(title: "Secundário",
                         buttonType: .secundaryType,
                         action: {})
            }
            .padding()
            .previewDisplayName("Possíveis tipos")
    }
}
