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
    
    var body: some View {
        VStack {
            HeaderPage
            Spacer()
            
            TextFieldEmail
            
            Spacer(minLength: 20)
            
            ButtonsStack
            
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
    private var HeaderPage: some View {
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
    
    private var TextFieldEmail: some View {
        ZStack(alignment: .trailing) {
            TextFieldView(title: "Qual seu e-mail de cadastro?", placeholder: "Digite seu e-mail", text: $viewModel.user.email, prompt: "")
            
            if !viewModel.user.email.isEmpty {
                if viewModel.isCorrectEmail {
                    Image(systemName: "checkmark.circle.fill")
                        .imageScale(.large)
                        .foregroundColor(Color(.systemGreen))
                } else {
                    Image(systemName: "xmark.circle.fill")
                        .imageScale(.large)
                        .foregroundColor(Color(.systemRed))
                }
            }
        }
        .padding()
    }
    
    private var ButtonsStack: some View {
        VStack(spacing: 5) {
            PJButton(title: "Entrar", buttonType: .primaryType) {
                viewModel.reAuthentication()
                self.isWaitingCode = true
            }
            .disabled(!viewModel.isCorrectEmail)
            .opacity(viewModel.isCorrectEmail ? 1 : 0.5)
            
            waitingCode
            
            PJButton(title: "Cancelar", buttonType: .secundaryType) {

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
