import SwiftUI

extension View {
    /// Creates a custom navigation bar with a back button and a title.
    ///
    /// - Parameters:
    ///   - title: The title of the navigation bar.
    ///   - onClick: An action to be executed when the back button is pressed.
    ///
    /// - Returns: A view that represents the custom navigation bar.
    func customNavigationBar(title: String, onClick: @escaping (() -> Void) = {}) -> some View {
        return HStack {
            Button {
                onClick()
            } label: {
                Image(systemName: "chevron.backward")
                    .foregroundStyle(Color(.petPrimary500))
            }
            Spacer()
            Text(title)
                .offset(x: -20.0)
            Spacer()
        }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 50, maxHeight: 50)
            .padding(.leading)
    }
    
    func dateFormatter(text: Binding<String>) -> some View {
        self.modifier(DateFormatterModifier(text: text))
    }
}

struct DateFormatterModifier: ViewModifier {
    @Binding var text: String
    
    func body(content: Content) -> some View {
        content
            .onChange(of: text) { oldValue, newValue in
                let formattedText = formatDateText(newValue)
                if formattedText != newValue {
                    text = formattedText
                }
            }
    }
    
    private func formatDateText(_ input: String) -> String {
        let numbersOnly = input.filter { $0.isNumber }
        
        let limited = String(numbersOnly.prefix(8))
        
        var formatted = ""
        for (index, char) in limited.enumerated() {
            if index == 2 || index == 4 {
                formatted += "/"
            }
            formatted.append(char)
        }
        
        return formatted
    }
}
