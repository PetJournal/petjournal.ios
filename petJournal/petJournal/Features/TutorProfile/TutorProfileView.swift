import SwiftUI

struct TutorProfileView: View {
    @State private var showAlert = false
    @StateObject var viewModel: AccessAccountViewModel
    
    var body: some View {
        VStack {
            Spacer()
            
            PJButton(title: "Logout",
                     buttonType: .secundaryType) {
                showAlert = true
            }
            .actionSheet(isPresented: $showAlert) {
                ActionSheet(title: Text("Deseja realmente sair?"), buttons: [
                    .cancel(Text("Cancelar")) { },
                    .destructive(Text("Sair")) {
                        viewModel.logout()
                    }
                ])
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
