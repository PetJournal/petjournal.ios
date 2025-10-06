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
                        router.navigateBack()
                    }
                    viewModel.dismissAlert()
                }),
                secondaryButton: viewModel.alertSecondaryButtonTitle != nil ? AnyView(
                    PJButton.secondary(viewModel.alertSecondaryButtonTitle!) {
                        Task { await viewModel.deletePet() }
                    }
                ) : nil,
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
