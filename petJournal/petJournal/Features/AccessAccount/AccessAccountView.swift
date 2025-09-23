import SwiftUI

struct AccessAccountView: View {
    @StateObject var viewModel = AccessAccountViewModel()
    
    @EnvironmentObject var router: NavigationRouter
    @State private var isPasswordVisible: Bool = false
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 30) {
                headerView
                
                VStack(spacing: 8) {
                    emailField
                    passwordField
                    rememberAndForgot
                }
                
                Spacer()
                
                VStack {
                    loginButton(geometry: geometry)
                    componentCreateAccount
                }
                Spacer()
            }
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color.white)
            .alert("Login", isPresented: $viewModel.showAlert) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(viewModel.errorMessage)
            }
        }
    }
}

// MARK: - Extension
extension AccessAccountView {
    private var headerView: some View {
        VStack {
            Image(asset: .logoPrimary)
                .resizable()
                .scaledToFit()
                .frame(width: 148, height: 118)
            
            Text("Acessar conta")
                .font(.fredokaMedium(size: .biggest))
        }
        .padding(.bottom, 30)
    }
    
    private var emailField: some View {
        PJTextFieldView(
            error: viewModel.emailErrorMessage,
            errorValidation: viewModel.isValidEmail,
            title: "Login",
            placeholder: "Digite seu e-mail",
            textContentType: .emailAddress,
            validateFieldCallBack: { _ in viewModel.isValidEmail },
            text: $viewModel.user.email
        )
    }
    
    private var passwordField: some View {
        PJTextFieldView(
            error: viewModel.passwordErrorMessage,
            errorValidation: viewModel.isValidPassword,
            title: "Senha",
            placeholder: "Digite sua senha",
            textContentType: .password,
            validateFieldCallBack: { _ in viewModel.isValidPassword },
            text: $viewModel.user.password
        )
    }
    
    private var rememberAndForgot: some View {
        HStack {
            CompRememberAndForgotPassword()
            
            Button {
                router.navigateAuth(to: .forgotPassword)
            } label: {
                Text("Esqueci minha senha")
                    .font(.fredokaMedium(size: .tiny))
                    .foregroundColor(Color.theme.petBlack)
            }
        }
    }
    
    private func loginButton(geometry: GeometryProxy) -> some View {
        PJButton(
            title: "Continuar",
            buttonType: .primaryType
        ) {
            Task {
                await viewModel.authUser()
            }
        }
        .frame(width: geometry.size.width * 0.45)
        .disabled(!viewModel.completeLogin || viewModel.isLoading)
    }
    
    private var componentCreateAccount: some View {
        HStack {
            Text("Não tem uma conta?")
                .font(.fredokaMedium(size: .tiny))
            
            Button {
                router.navigateAuth(to: .createAccount)
            } label: {
                Text("Inscrever-se")
                    .font(.fredokaMedium(size: .tiny))
                    .foregroundColor(Color.theme.petBlack)
            }
        }
    }
}

#Preview {
    AccessAccountView()
        .environmentObject(NavigationRouter())
        .environmentObject(SessionManager())
}
