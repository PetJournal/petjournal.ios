//
//  CreateAccountView.swift
//  petJournal
//
//  Created by Daiane Goncalves on 16/05/23.
//

import SwiftUI

struct CreateAccountView: View {
    @StateObject var viewModel = CreateAccountViewModel(service: CreateAccountService())
    
    @State private var showWebview = false
    @State private var privacyConfirm = false
    @State private var visiblePassword = false
    @State private var visiblePasswordMacth = false
    @State private var isLoginView: Bool = false
    @State private var showAlert: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                headerView
                textFieldsRegister
                
                ComponentPrivacy(isRemember: privacyConfirm) { self.showWebview = true }
                
                registerView
                Spacer()
                loginNavigation
            }
            .sheet(isPresented: $showWebview) {
                WebView(link: "https://www.google.com")
                buttonsPrivacyPolicy
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color.theme.petWhite)
            
            if showAlert {
                CustomAlert(show: $showAlert, titleAlert: "Register", descriptionAlert: "Registration successfully completed. \nLog in to the app.", buttonTitle: "OK") {
                    isLoginView = true
                }
            }
        }
    }
}

// MARK: - Extension CreateAccountView 
extension CreateAccountView {
    private var headerView: some View {
        VStack(spacing: 0) {
            Image("pet_logoPrimary")
                .resizable()
                .frame(width: 80, height: 70)
            
            Text("Inscreva-se")
                .font(.system(size: 20))
        }
    }
    
    private var textFieldsRegister: some View {
        ScrollView(showsIndicators: false) {
            TextFieldView(title: "Nome", placeholder: "Nome", text: $viewModel.user.name, prompt: "")
            TextFieldView(title: "Sobrenome", placeholder: "Sobrenome", text: $viewModel.user.lastName, prompt: "")
            TextFieldView(title: "E-mail", placeholder: "E-mail", text: $viewModel.user.email, prompt: "")
            TextFieldView(title: "Telefone", placeholder: "Telefone", text: $viewModel.user.phoneNumber, prompt: "")
            
            CustomTextField(isPasswordVisible: $visiblePassword, text: $viewModel.user.password, placeholder: "Senha", prompt: "", title: "Senha")
            CustomTextField(isPasswordVisible: $visiblePasswordMacth, text: $viewModel.user.passwordMatch, placeholder: "Confirmar senha", prompt: "Senha", title: "Confirmar senha")
        }
        .padding(16)
    }
    
    private var registerView: some View {
        VStack {
            PJButton(title: "Cadastrar", buttonType: .primaryType) {
                viewModel.registerUser()
            }
            .disabled(!viewModel.completeRegister)
            .opacity(viewModel.completeRegister ? 1 : 0.4)
        }
        .frame(width: 300)
        .alert("titleErrorDomain", isPresented: $viewModel.cancel) {
        } message: {
            switch viewModel.error {
            case .register:
                Text("errorDomain")
            case .none:
                Text("")
            }
        }
    }
    
    private var buttonsPrivacyPolicy: some View {
        HStack(spacing: 10) {
            PJButton(title: "Concordo", buttonType: .primaryType) {
                showWebview = false
            }
            
            PJButton(title: "Discordo", buttonType: .secundaryType) {
                showWebview = false
            }
        }
        .padding()
    }
    
    private var loginNavigation: some View {
        HStack {
            NavigationLink(
                destination: AccessAccountView(viewModel: AccessAccountViewModel(service: AccessAccountService())).navigationBarHidden(true),
                isActive: self.$isLoginView) {EmptyView()}
                .isDetailLink(false)
                .navigationBarHidden(true)
        }
    }
}
