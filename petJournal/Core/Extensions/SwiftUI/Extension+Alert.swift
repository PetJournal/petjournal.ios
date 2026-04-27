import SwiftUI

extension Alert {
    init(localizedError: LocalizedError) {
        self = Alert(nsError: localizedError as NSError)
    }
    
    init(nsError: NSError) {
        let message: Text? = {
            let message = [nsError.localizedFailureReason, nsError.localizedRecoverySuggestion].compactMap({ $0 }).joined(separator: "\n\n")
            return message.isEmpty ? nil : Text(message)
        }()
        self = Alert(title: Text(nsError.localizedDescription),
                     message: message,
                     dismissButton: .default(Text("OK")))
    }
}
