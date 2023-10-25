//
//  InputEmailView.swift
//  petJournal
//
//  Created by Marcylene Barreto on 14/06/23.
//

import SwiftUI

struct InputEmailView: View {
    @StateObject var viewModel: ForgotPasswordViewModel
    @State private var isWaitingCode: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            headerPage
            Spacer()
            
            textFieldEmail
            
            Spacer(minLength: 20)
            
            buttonsStack
            
            Spacer()
        }
        .alert("forgotpassword-domain-error", isPresented: $viewModel.cancel) {
        } message: {
            switch viewModel.error {
            case .domainErr:
                Text("forgotpassword-domain-error-text")
            case .none:
                Text("")
            case .invalidMail:
                Text("forgotpassword-login-error")
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}

extension InputEmailView {
    private var headerPage: some View {
        VStack(spacing: 5) {
            Image("pet_logoPrimary")
                .resizable()
                .frame(width: 138, height: 118)
                .padding([.bottom, .top], 25)
            Text("forgotpassword-title")
                .font(.title2)
                .bold()
            
            Text("forgotpassword-subtitle")
                .font(.callout)
                .fontWeight(.light)
        }
    }
    
    private var textFieldEmail: some View {
        ZStack(alignment: .trailing) {
            PJTextFieldView(error: viewModel.emailErrorMessage,
                            errorValidation: viewModel.isValidEmail,
                            title: "forgotpassword-email-field".localized,
                            placeholder: "forgotpassword-email-field-placeholder".localized,
                            textContentType: .emailAddress,
                            validateFieldCallBack: { text in
                return self.viewModel.isValidPhone
            },
                            text: $viewModel.emailOrPhone)
            
            if !viewModel.emailOrPhone.isEmpty {
                if viewModel.isCorrectCredentials {
                    Image(systemName: "checkmark.circle.fill")
                        .imageScale(.large)
                        .padding(.horizontal)
                        .foregroundColor(Color(.systemGreen))
                    
                } else {
                    Image(systemName: "xmark.circle.fill")
                        .imageScale(.large)
                        .padding(.horizontal)
                        .foregroundColor(Color(.systemRed))
                }
            }
        }
        .padding(.horizontal)
    }
    
    private var buttonsStack: some View {
        VStack(spacing: 5) {
            PJButton(title: "forgotpassword-enter".localized, buttonType: .primaryType) {
                viewModel.reAuthentication()
                self.isWaitingCode = true
            }
            .disabled(!viewModel.isCorrectCredentials)
            .opacity(viewModel.isCorrectCredentials ? 1 : 0.5)
            
            waitingCode
            
            PJButton(title: "forgotpassword-cancel".localized, buttonType: .secundaryType) {
                dismiss()
            }
        }
        .padding([.leading,.trailing], 60)
    }
    
    private var waitingCode: some View {
        HStack {
            NavigationLink(
                destination:
                    WaitingCodeView()
                    .navigationBarHidden(true),
                isActive: self.$isWaitingCode) {EmptyView()}
                .isDetailLink(false)
                .navigationBarHidden(true)
        }
    }
}
