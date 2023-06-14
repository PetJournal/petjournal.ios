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
    
//    @StateObject var testViewModel = AccessAccountVM()
    @EnvironmentObject var loginAuth: SessionVM
    
    // MARK: - State
    @State private var isPasswordVisible: Bool = false
    @State private var isAccessAccount: Bool = false
    @State private var isCreateAccount: Bool = false
    
    // MARK: - Body
    var body: some View {
            VStack(spacing: 30) {
                Image("pet_logoPrimary")
                    .resizable()
                    .frame(width: 148, height: 118)
                
                VStack(spacing: 10) {
                    TextFieldView(title: "titleFieldMail", placeholder: "textFieldMail", text: $viewModel.user.email, prompt: "error")
                    CustomTextField(isPasswordVisible: $isPasswordVisible, text: $viewModel.user.password, hint: "textFieldPass", prompt: "Error", title: "titleFieldPass")
                }
                
                rememberAndForgot
                
                VStack {
                    PJButton(title: "Entrar", buttonType: .primaryType) {
                        viewModel.loginUser { result in
                            loginAuth.updateValidation(success: result, email: viewModel.user.email)
                        }
                    }
                    .disabled(!viewModel.completeLogin)
                    .opacity(viewModel.completeLogin ? 1 : 0.4)
                    
                    componentCreateAccount
                }
//                Spacer()
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
                destination: ForgotPasswordView(viewModel: ForgotPasswordViewModel(service: ForgotPasswordService())).navigationBarHidden(true),
                isActive: self.$isAccessAccount) {
                    Text("forgotButton")
                        .foregroundColor(.black)
                }
                .isDetailLink(false)
                .navigationBarHidden(true)
        }
    }
    
    private var componentCreateAccount: some View {
        HStack {
            Text("createAccount")
            
            NavigationLink(
                destination: Text("Create Account").navigationBarHidden(true),
                isActive: self.$isCreateAccount) {
                    Text("inscrevase")
                        .foregroundColor(.blue)
                }
                .isDetailLink(false)
                .navigationBarHidden(true)
        }
    }
}
