//
//  InputEmailView.swift
//  petJournal
//
//  Created by Marcylene Barreto on 14/06/23.
//

import SwiftUI

struct InputEmailView: View {
    @EnvironmentObject var router: NavigationRouter
    @StateObject var viewModel: ForgotPasswordViewModel
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
        .alert("Error Domain", isPresented: $viewModel.cancel) {
        } message: {
            switch viewModel.error {
            case .domainErr:
                Text("Your domain is different from petjournal.com.")
            case .none:
                Text("")
            case .invalidMail:
                Text("Error logging in. Please check the email is correct and try again.")
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}

extension InputEmailView {
    private var headerPage: some View {
        VStack(spacing: 5) {
            Image(asset: .logoPrimary)
                .resizable()
                .frame(width: 138, height: 118)
                .padding([.bottom, .top], 25)
            Text("Esqueceu a senha?")
                .font(.title2)
                .bold()
            
            Text("Redefina a senha em duas etapas")
                .font(.callout)
                .fontWeight(.light)
        }
    }
    
    private var textFieldEmail: some View {
        ZStack(alignment: .trailing) {
            PJTextFieldView(error: viewModel.emailErrorMessage,
                            errorValidation: viewModel.isValidEmail,
                            title: "E-mail ou Telefone",
                            placeholder: "Digite seu e-mail ou telefone",
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
            PJButton(title: "Entrar", buttonType: .primaryType) {
                viewModel.reAuthentication()
                router.navigate(to: .waitingCode)
            }
            .disabled(!viewModel.isCorrectCredentials)
            .opacity(viewModel.isCorrectCredentials ? 1 : 0.5)
            
            PJButton(title: "Cancelar", buttonType: .secundaryType) {
                dismiss()
            }
        }
        .padding([.leading,.trailing], 60)
    }
}

#Preview {
    InputEmailView(viewModel: ForgotPasswordViewModel(service: ForgotPasswordService()))
}
