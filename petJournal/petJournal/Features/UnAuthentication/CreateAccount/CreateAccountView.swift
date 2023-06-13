//
//  CreateAccountView.swift
//  petJournal
//
//  Created by Daiane Goncalves on 16/05/23.
//

import SwiftUI

struct CreateAccountView: View {
    @StateObject var viewModel = CreateAccountViewModel(service: CreateAccountService())
    
    @State var showWebview = false
    @State var privacyConfirm = false
    @State var visiblePassword = false
    @State var visiblePasswordMacth = false
    @State private var isLoginView: Bool = false
    @State private var showAlert: Bool = false
    
    var body: some View {
        ZStack {
            VStack {
                HeaderView
                TextFieldsRegister
                
                ComponentPrivacy(isRemember: privacyConfirm) { self.showWebview = true }
                
                RegisterView
                Spacer()
                LoginNavigation
            }
            .sheet(isPresented: $showWebview) {
                WebView()
                ButtonsPrivacyPolicy
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
    private var HeaderView: some View {
        VStack(spacing: 0) {
            Image("pet_logoPrimary")
                .resizable()
                .frame(width: 80, height: 70)
            
            Text("Inscreva-se")
                .font(.system(size: 20))
        }
    }
    
    private var TextFieldsRegister: some View {
        ScrollView(showsIndicators: false) {
            TextFieldView(title: "Nome", placeholder: "Nome", text: $viewModel.user.name, prompt: "")
            TextFieldView(title: "Sobrenome", placeholder: "Sobrenome", text: $viewModel.user.lastName, prompt: "")
            TextFieldView(title: "E-mail", placeholder: "E-mail", text: $viewModel.user.email, prompt: "")
            TextFieldView(title: "Telefone", placeholder: "Telefone", text: $viewModel.user.phoneNumber, prompt: "")
            
            CustomTextField(isPasswordVisible: $visiblePassword, text: $viewModel.user.password, hint: "Senha", prompt: "", title: "Senha")
            CustomTextField(isPasswordVisible: $visiblePasswordMacth, text: $viewModel.user.passwordMatch, hint: "Confirmar senha", prompt: "Senha", title: "Confirmar senha")
        }
        .padding(16)
    }
    
    private var RegisterView: some View {
        VStack {
            PJButton(title: "Cadastrar", buttonType: .primaryType) {
                viewModel.registerUser()
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        showAlert = true
                    }
                }
            }
            .disabled(!viewModel.completeRegister)
            .opacity(viewModel.completeRegister ? 1 : 0.4)
        }
        .frame(width: 300)
    }
    
    private var ButtonsPrivacyPolicy: some View {
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
    
    private var LoginNavigation: some View {
        HStack {
            NavigationLink(
                destination: AccessAccountView().navigationBarHidden(true),
                isActive: self.$isLoginView) {EmptyView()}
                .isDetailLink(false)
                .navigationBarHidden(true)
        }
    }
}
