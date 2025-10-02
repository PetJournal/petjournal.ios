import SwiftUI

struct PetRegisterAlert: View {
    @ObservedObject var viewModel: PetRegisterViewModel
    @EnvironmentObject var router: NavigationRouter
    
    var body: some View {
        if viewModel.showAlert {
            CustomAlertView(
                isPresented: $viewModel.showAlert,
                image: viewModel.alertImage,
                message: viewModel.alertMessage,
                primaryButton: AnyView(PJButton.primary(viewModel.alertButtonTitle) {
                    if viewModel.isSuccessAlert {
                        router.navigateBack(in: 2)
                    }
                    viewModel.dismissAlert()
                }),
                secondaryButton: nil,
                buttonDirection: .vertical
            )
        }
    }
}

#Preview {
    let viewModel = PetRegisterViewModel()
    viewModel.isSuccessAlert = true
    viewModel.showAlert = true
    viewModel.alertMessage = "Pet cadastrado com sucesso!"
    
    return PetRegisterAlert(viewModel: viewModel)
        .environmentObject(NavigationRouter())
}
