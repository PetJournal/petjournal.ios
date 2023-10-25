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
    @State private var isLoginView: Bool = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                headerView
                textFieldsRegister
                
                ComponentPrivacy { self.showWebview = true }
                    .padding(.vertical, 25)
                
                buttonRegister
                    .frame(width: geometry.size.width * 0.45)
                Spacer()
                loginNavigation
            }
            .sheet(isPresented: $showWebview) {
                WebView(link: "https://www.google.com")
                buttonsPrivacyPolicy
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color.theme.petWhite)
        }
        .environmentObject(viewModel)
    }
}

// MARK: - Extension CreateAccountView
extension CreateAccountView {
    private var headerView: some View {
        VStack(spacing: 15) {
            Image("pet_logoPrimary")
                .resizable()
                .scaledToFit()
                .frame(width: 76, height: 76)
            
            Text("Inscreva-se")
                .font(.fedokaMedium(size: .biggest))
        }
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
                                text: $viewModel.user.name)
                
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
                                text: $viewModel.user.phoneNumber)
                
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
                                text: $viewModel.user.passwordMatch)
            }
            .padding(.horizontal, 16)
        }
    }
    
    private var buttonRegister: some View {
        VStack {
            PJButton(title: "Continuar", buttonType: .primaryType) {
                viewModel.registerUser()
            }
            .disabled(!viewModel.completeRegister)
        }
        .alert(isPresented: $viewModel.cancel) {
            Alert(title: Text("Registro"),
                  message: Text("\(viewModel.emailJaRegistrado)"),
                  primaryButton: .cancel(),
                  secondaryButton: .destructive(
                    Text("OK"),
                    action: {
                        if viewModel.emailJaRegistradoAction {
                            self.isLoginView = false
                        } else {
                            self.isLoginView = true
                        }
                    }
                  )
            )
        }
    }
    
    private var buttonsPrivacyPolicy: some View {
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
