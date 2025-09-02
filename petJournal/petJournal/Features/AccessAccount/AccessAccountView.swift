//
//  AccessAccountView.swift
//  petJournal
//
//  Created by Marcylene Barreto on 16/05/23.
//

import SwiftUI

struct AccessAccountView: View {
    // MARK: - StateObject
    @StateObject var viewModel: AccessAccountViewModel
    
    @EnvironmentObject var loginAuth: SessionManager
    @EnvironmentObject var router: NavigationRouter
    
    // MARK: - State
    @State private var isPasswordVisible: Bool = false
    
    // MARK: - Body
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 30) {
                VStack {
                    Image(asset: .logoPrimary)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 148, height: 118)
                    
                    Text("Acessar conta")
                        .font(.fredokaMedium(size: .biggest))
                }
                .padding(.bottom, 30)
                
                VStack(spacing: 8) {
                    PJTextFieldView(error: viewModel.emailErrorMessage,
                                    errorValidation: viewModel.isValidEmail,
                                    title: "Login",
                                    placeholder: "Digite seu e-mail",
                                    textContentType: .emailAddress, 
                                    validateFieldCallBack: { text in return self.viewModel.isValidEmail},
                                    text: $viewModel.user.email)
                    
                    PJTextFieldView(error: viewModel.passwordErrorMessage,
                                    errorValidation: viewModel.isValidPassword,
                                    title: "Senha",
                                    placeholder: "Digite sua senha",
                                    textContentType: .password,
                                    validateFieldCallBack: { text in return self.viewModel.isValidPassword},
                                    text: $viewModel.user.password)
                    rememberAndForgot
                }
                Spacer()
                VStack {
                    PJButton(title: "Continuar", buttonType: .primaryType) {
                        viewModel.authUser()
                    }
                    .frame(width: geometry.size.width * 0.45)
                    .disabled(!viewModel.areCredentialsValid())
                    .opacity(viewModel.areCredentialsValid() ? 1 : 0.4)
                    .alert(isPresented: $viewModel.cancel) {
                        Alert(title: Text("Login"),
                              message: Text("\(viewModel.emailOrPasswordIncorrect)"),
                              dismissButton: .cancel(Text("OK"))
                        )
                    }
                    
                    componentCreateAccount
                }
                Spacer()   
            }
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color.white)
            
        }
    }
}

// MARK: - Extension
extension AccessAccountView {
    private var rememberAndForgot: some View {
        HStack {
            CompRememberAndForgotPassword()
            
            Button {
                router.navigate(to: .forgotPassword)
            } label: {
                Text("Esqueci minha senha")
                    .font(.fredokaMedium(size: .tiny))
                    .foregroundColor(Color.theme.petBlack)
            }
        }
    }
    
    private var componentCreateAccount: some View {
        HStack {
            Text("Não tem uma conta?")
                .font(.fredokaMedium(size: .tiny))
            
            Button {
                router.navigate(to: .createAccount)
            } label: {
                Text("Inscrever-se")
                    .font(.fredokaMedium(size: .tiny))
                    .foregroundColor(Color.theme.petBlack)
            }
        }
    }
}
#Preview {
    AccessAccountView(viewModel: AccessAccountViewModel(service: AccessAccountService()))
        .environmentObject(SessionManager())
}
