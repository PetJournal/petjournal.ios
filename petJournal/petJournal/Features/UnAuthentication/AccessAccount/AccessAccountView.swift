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
    
    // MARK: - State
    @State private var isPasswordVisible: Bool = false
    @State private var isAccessAccount: Bool = false
    @State private var isCreateAccount: Bool = false
    
    // MARK: - Body
    var body: some View {
        VStack(spacing: 30) {
            VStack {
                Image("pet_logoPrimary")
                    .resizable()
                    .frame(width: 148, height: 118)
                
                Text("Acessar conta")
                    .font(.title2)
            }
            .padding(.bottom, 30)
            
            VStack(spacing: 5) {
                PJTextFieldView(error: viewModel.emailErrorMessage,
                                errorValidation: viewModel.isValidEmail,
                                title: "E-mail",
                                placeholder: "Digite seu e-mail",
                                textContentType: .emailAddress,
                                text: $viewModel.user.email)
                
                PJTextFieldView(error: viewModel.passwordErrorMessage,
                                errorValidation: viewModel.isValidPassword,
                                title: "Senha",
                                placeholder: "Digite sua senha",
                                textContentType: .password,
                                text: $viewModel.user.password)
            }
            
            rememberAndForgot
            
            VStack {
                PJButton(title: "Entrar", buttonType: .primaryType) {
                    viewModel.authUser()
                }
//                .disabled(viewModel.completeLogin())
//                .opacity(!viewModel.completeLogin() ? 1 : 0.4)
                
                componentCreateAccount
            }
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .background(Color.white)
    }
}

// MARK: - Extension
extension AccessAccountView {
    private var rememberAndForgot: some View {
        HStack {
            CompRememberAndForgotPassword()
            
            NavigationLink(
                destination: InputEmailView(viewModel: ForgotPasswordViewModel(service: ForgotPasswordService())).navigationBarHidden(true),
                isActive: self.$isAccessAccount) {
                    Text("Esqueci minha senha")
                        .foregroundColor(.black)
                }
                .isDetailLink(false)
                .navigationBarHidden(true)
        }
    }
    
    private var componentCreateAccount: some View {
        HStack {
            Text("Não tem uma conta?")
            
            NavigationLink(
                destination: CreateAccountView().navigationBarHidden(true),
                isActive: self.$isCreateAccount) {
                    Text("Inscrever-se")
                        .foregroundColor(.black)
                }
                .isDetailLink(false)
                .navigationBarHidden(true)
        }
    }
}
