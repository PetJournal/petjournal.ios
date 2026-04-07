import SwiftUI

struct ComponentCreateAccount: View {
    var action: () -> Void
    
    var body: some View {
        HStack {
            Text("Não tem conta?")
            
            Button(action: { action() }) {
                Text("Inscreva-se")
            }
        }
    }
}
