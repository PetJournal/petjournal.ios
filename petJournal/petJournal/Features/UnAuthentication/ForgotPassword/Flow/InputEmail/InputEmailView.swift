//
//  InputEmailView.swift
//  petJournal
//
//  Created by Marcylene Barreto on 14/06/23.
//

import SwiftUI

struct InputEmailView: View {
    @ObservedObject var viewModel = ForgotPasswordViewModel(service: ForgotPasswordService())
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            headerPage
            Spacer()
            
            textFieldEmail
            
            Spacer(minLength: 20)
            
            buttonsStack
            
            Spacer()
            
            waitingCode
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
            case .invalidUrl:
                Text("Invalid URL")
            case .noData:
                Text("Error, Empty data")
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
                            text: $viewModel.email)
            
            if !viewModel.email.isEmpty {
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
                viewModel.forgetPassword()
            }
            .disabled(!viewModel.isCorrectCredentials)
            .opacity(viewModel.isCorrectCredentials ? 1 : 0.5)
            
            PJButton(title: "Cancelar", buttonType: .secundaryType) {
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
                isActive: $viewModel.isWaitingCode) {EmptyView()}
                .isDetailLink(false)
                .navigationBarHidden(true)
        }
    }
}
