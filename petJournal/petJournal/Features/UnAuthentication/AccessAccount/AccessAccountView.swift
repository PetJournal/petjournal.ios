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
        GeometryReader { geometry in
            VStack(spacing: 30) {
                VStack {
                    Image("pet_logoPrimary")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 148, height: 118)
                    
                    Text("account-title")
                        .font(.fedokaMedium(size: .biggest))
                }
                .padding(.bottom, 30)
                
                VStack(spacing: 8) {
                    PJTextFieldView(error: viewModel.emailErrorMessage,
                                    errorValidation: viewModel.isValidEmail,
                                    title: "account-login".localized,
                                    placeholder: "account-email-placeholder".localized,
                                    textContentType: .emailAddress, 
                                    validateFieldCallBack: { text in return self.viewModel.isValidEmail},
                                    text: $viewModel.user.email)
                    
                    PJTextFieldView(error: viewModel.passwordErrorMessage,
                                    errorValidation: viewModel.isValidPassword,
                                    title: "account-password".localized,
                                    placeholder: "account-password-placeholder".localized,
                                    textContentType: .password,
                                    validateFieldCallBack: { text in return self.viewModel.isValidPassword},
                                    text: $viewModel.user.password)
                    rememberAndForgot
                }
                Spacer()
                VStack {
                    PJButton(title: "account-continue-button-title".localized, buttonType: .primaryType) {
                        viewModel.authUser()
                    }
                    .frame(width: geometry.size.width * 0.45)
                    .disabled(viewModel.completeLogin())
                    .opacity(!viewModel.completeLogin() ? 1 : 0.4)
                    
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
            
            NavigationLink(
                destination: InputEmailView(viewModel: ForgotPasswordViewModel(service: ForgotPasswordService())).navigationBarHidden(true),
                isActive: self.$isAccessAccount) {
                    Text("account-forgotpassword")
                        .font(.fedokaMedium(size: .tiny))
                        .foregroundColor(.black)
                }
                .isDetailLink(false)
                .navigationBarHidden(true)
        }
    }
    
    private var componentCreateAccount: some View {
        HStack {
            Text("createaccount-message")
                .font(.fedokaMedium(size: .tiny))
            
            NavigationLink(
                destination: CreateAccountView().navigationBarHidden(true),
                isActive: self.$isCreateAccount) {
                    Text("createaccount-button-message")
                        .font(.fedokaMedium(size: .tiny))
                        .foregroundColor(.black)
                }
                .isDetailLink(false)
                .navigationBarHidden(true)
        }
    }
}
