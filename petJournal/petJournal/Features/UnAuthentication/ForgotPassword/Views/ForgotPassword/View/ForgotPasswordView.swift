//
//  ForgotPasswordView.swift
//  petJournal
//
//  Created by Marcylene Barreto on 11/05/23.
//

import SwiftUI

struct ForgotPasswordView: View {
    @Environment(\.rootPresentationMode) private var rootPresentationMode: Binding<RootPresentationMode>
    @StateObject var viewModel: ForgotPasswordViewModel
    @State private var isWaitingCode: Bool = false
    
    var body: some View {
//        NavigationView {
            VStack {
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
                Spacer()
                
                VStack {
                    TextFieldView(title: "Qual seu e-mail de cadastro?", placeholder: "Digite seu e-mail", text: $viewModel.user.email, prompt: "")
                }
                .padding()
                
                Spacer(minLength: 20)
                
                VStack(spacing: 5) {
                    PJButton(title: "Entrar", buttonType: .primaryType) {
                        viewModel.reAuthentication()
                        self.isWaitingCode = true
                    }
                    waitingCode
                    
                    PJButton(title: "Cancelar", buttonType: .secundaryType) {
                        self.rootPresentationMode.wrappedValue.dismiss()
                    }
                }
                .padding([.leading,.trailing], 60)
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
//        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .navigationViewStyle(StackNavigationViewStyle())
//        .environment(\.rootPresentationMode, self.$isWaitingCode)
    }
}

extension ForgotPasswordView {
    private var waitingCode: some View {
        HStack {
            NavigationLink(
                destination:
                    WaitingCode()
                    .navigationBarHidden(true),
                isActive: self.$isWaitingCode) {EmptyView()}
                .isDetailLink(false)
                .navigationBarHidden(true)
        }
    }
}
