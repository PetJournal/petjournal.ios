import SwiftUI

struct TutorProfileView: View {
    @State private var showAlert = false
    @StateObject var viewModel = AccessAccountViewModel()
    
    var body: some View {
        ScrollView() {
            VStack() {
                PJButton.secondary("Logout", action: {
                    showAlert = true
                })
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
        }
    }
}

struct TutorProfileView_Previews: PreviewProvider {
    static var previews: some View {
        TutorProfileView()
    }
}
