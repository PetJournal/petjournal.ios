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
        ZStack {
            VStack {
                headerView
                textFieldsRegister
                
                ComponentPrivacy { self.showWebview = true }
                
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
        }
        .environmentObject(viewModel)
    }
}

// MARK: - Extension CreateAccountView
extension CreateAccountView {
    private var headerView: some View {
        VStack(spacing: 0) {
            Image("pet_logoPrimary")
                .resizable()
                .frame(width: 80, height: 70)
            
            Text("register-title")
                .font(.system(size: 20))
        }
    }
    
    private var textFieldsRegister: some View {
        
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 5) {
                PJTextFieldView(error: viewModel.firstNameErrorMessage,
                                errorValidation: viewModel.isValidName,
                                title: "textfield-name".localized,
                                placeholder: "textfield-name-placeholder".localized,
                                textContentType: .name,
                                validateFieldCallBack: { text in
                    return self.viewModel.isValidName
                },
                                text: $viewModel.user.name)
                
                PJTextFieldView(error: viewModel.lastNameErrorMessage,
                                errorValidation: viewModel.isValidLastname,
                                title: "textfield-last-name".localized,
                                placeholder: "textfield-last-name-placeholder".localized,
                                textContentType: .givenName,
                                validateFieldCallBack: { text in
                    return self.viewModel.isValidLastname
                },
                                text: $viewModel.user.lastName)
                
                PJTextFieldView(error: viewModel.emailErrorMessage,
                                errorValidation: viewModel.isValidEmail,
                                title: "textfield-email".localized,
                                placeholder: "textfield-email-placeholder".localized,
                                textContentType: .emailAddress,
                                validateFieldCallBack: { text in
                    return self.viewModel.isValidEmail
                },
                                text: $viewModel.user.email)
                
                PJTextFieldView(error: viewModel.phoneErrorMessage,
                                errorValidation: viewModel.isValidPhone,
                                title: "textfield-phone".localized,
                                placeholder: "textfield-phone-placeholder".localized,
                                textContentType: .telephoneNumber,
                                validateFieldCallBack: { text in
                    return self.viewModel.isValidPhone
                },
                                text: $viewModel.user.phoneNumber)
                
                PJTextFieldView(error: viewModel.messageErrorPassword,
                                errorValidation: viewModel.isValidPassword,
                                title: "textfield-password".localized,
                                placeholder: "textfield-password-placeholder".localized,
                                textContentType: .password,
                                validateFieldCallBack: { text in
                    return self.viewModel.isValidPassword
                },
                                text: $viewModel.user.password)
                .padding(.bottom, 20)
                
                PJTextFieldView(error: viewModel.messageErrorPasswordMatch,
                                errorValidation: viewModel.isValidPasswordMatch,
                                title: "textfield-password-confirm".localized,
                                placeholder: "textfield-password--confirm-placeholder".localized,
                                textContentType: .password,
                                validateFieldCallBack: { text in
                    return self.viewModel.isValidPasswordMatch
                },
                                text: $viewModel.user.passwordMatch)
            }
            .padding(.horizontal, 16)
        }
    }
    
    private var registerView: some View {
        VStack {
            PJButton(title: "register-button-message".localized, buttonType: .primaryType) {
                viewModel.registerUser()
            }
            .disabled(!viewModel.completeRegister)
            .opacity(viewModel.completeRegister ? 1 : 0.4)
        }
        .frame(width: 300)
        .alert(isPresented: $viewModel.cancel) {
            Alert(title: Text("register-alert-text"),
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
            PJButton(title: "privacy-agree".localized, buttonType: .primaryType) {
                viewModel.isCheckBox = true
                showWebview = false
            }
            
            PJButton(title: "privacy-disagree".localized, buttonType: .secundaryType) {
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
