import SwiftUI

extension View {
    func customNavigationBar(title: String, onClick: (() -> Void)? = nil) -> some View {
        return CustomNavigationBar(title: title, onClick: onClick)
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
