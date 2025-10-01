import SwiftUI

struct CreateAccountView: View {
    @EnvironmentObject var router: NavigationRouter
    @StateObject var viewModel = CreateAccountViewModel()
    @State private var showWebview = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                headerView
                textFieldsRegister
                
                privacyPolicyLink
                    .padding(.vertical, 10)
                
                buttonRegister
                    .frame(width: geometry.size.width * 0.45)
                Spacer()
            }
            .sheet(isPresented: $showWebview) {
                WebView(link: "https://www.google.com")
                privacyPolicyAgreementButtons
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color.theme.petWhite)
            .alert("Registro", isPresented: $viewModel.showAlert) {
                Button("OK") {
                    if viewModel.isRegister {
                        router.navigateAuth(to: .accessAccount)
                    }
                }
            } message: {
                Text(viewModel.registrationStatusMessage)
            }
        }
    }
}

// MARK: - Extension CreateAccountView
extension CreateAccountView {
    private var headerView: some View {
        VStack(spacing: 8) {
            Image(.petLogoPrimary)
                .resizable()
                .scaledToFit()
                .frame(width: 76, height: 76)
            
            Text("Inscreva-se")
                .font(.fredokaMedium(size: .biggest))
        }
        .padding(.bottom, 30)
    }
    
    private var textFieldsRegister: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
            VStack(spacing: 5) {
                PJTextFieldView(error: viewModel.firstNameErrorMessage,
                                errorValidation: viewModel.isValidName,
                                title: "Nome",
                                placeholder: "Digite seu primeiro nome",
                                textContentType: .name,
                                validateFieldCallBack: { text in
                    return self.viewModel.isValidName
                },
                                text: $viewModel.user.firstName)
                
                PJTextFieldView(error: viewModel.lastNameErrorMessage,
                                errorValidation: viewModel.isValidLastname,
                                title: "Sobrenome",
                                placeholder: "Digite seu sobrenome",
                                textContentType: .givenName,
                                validateFieldCallBack: { text in
                    return self.viewModel.isValidLastname
                },
                                text: $viewModel.user.lastName)
                
                PJTextFieldView(error: viewModel.emailErrorMessage,
                                errorValidation: viewModel.isValidEmail,
                                title: "E-mail",
                                placeholder: "E-mail",
                                textContentType: .emailAddress,
                                validateFieldCallBack: { text in
                    return self.viewModel.isValidEmail
                },
                                text: $viewModel.user.email)
                
                PJTextFieldView(error: viewModel.phoneErrorMessage,
                                errorValidation: viewModel.isValidPhone,
                                title: "Telefone",
                                placeholder: "Telefone",
                                textContentType: .telephoneNumber,
                                validateFieldCallBack: { text in
                    return self.viewModel.isValidPhone
                },
                                text: $viewModel.user.phone)
                
                PJTextFieldView(error: viewModel.messageErrorPassword,
                                errorValidation: viewModel.isValidPassword,
                                title: "Senha",
                                placeholder: "Senha",
                                textContentType: .password,
                                validateFieldCallBack: { text in
                    return self.viewModel.isValidPassword
                },
                                text: $viewModel.user.password)
                
                PJTextFieldView(error: viewModel.messageErrorPasswordMatch,
                                errorValidation: viewModel.isValidPasswordMatch,
                                title: "Confirmar senha",
                                placeholder: "Confirmar senha",
                                textContentType: .password,
                                validateFieldCallBack: { text in
                    return self.viewModel.isValidPasswordMatch
                },
                                text: $viewModel.user.passwordConfirmation)
            }
            .padding(.horizontal, 16)
        }
    }
    
    private var buttonRegister: some View {
        VStack {
            PJButton(
                title: viewModel.isLoading ? "" : "Continuar",
                buttonType: .primaryType
            ) {
                Task {
                    await viewModel.registerUser()
                }
            }
            .disabled(!viewModel.completeRegister || viewModel.isLoading)
            .overlay {
                if viewModel.isLoading {
                    ProgressView()
                }
            }
        }
    }
    
    private var privacyPolicyAgreementButtons: some View {
        HStack(spacing: 10) {
            PJButton(title: "Concordo", buttonType: .primaryType) {
                viewModel.isCheckBox = true
                showWebview = false
            }
            
            PJButton(title: "Discordo", buttonType: .secundaryType) {
                viewModel.isCheckBox = false
                showWebview = false
            }
        }
        .padding()
    }
    
    private var privacyPolicyLink: some View {
        HStack {
            Button(action: {
                viewModel.isCheckBox.toggle()
            }) {
                Image(viewModel.isCheckBox ? .icCheckBoxSelect : .icCheckBoxClear)
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            Button(action: {
                self.showWebview = true
            }) {
                Text("Eu concordo com a política de privacidade")
                    .foregroundColor(Color.theme.petBlack)
                    .font(.fredokaMedium(size: .tiny))
            }
        }
    }
}

#Preview {
    CreateAccountView()
        .environmentObject(NavigationRouter())
}
