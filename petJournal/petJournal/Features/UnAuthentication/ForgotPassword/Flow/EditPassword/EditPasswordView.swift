//
//  EditPasswordView.swift
//  petJournal
//
//  Created by Marcylene Barreto on 14/06/23.
//

import SwiftUI

struct EditPasswordView: View {
    @StateObject var viewModel: EditPasswordViewModel
    @State var showAlert = false
    @State private var isLoginView: Bool = false
    
    var body: some View {
        VStack {
            Image("pet_logoPrimary")
                .resizable()
                .frame(width: 148, height: 128)
            
            Spacer()
            
            loginNavigation
            
            VStack(spacing: 10) {
                Text("Criar uma nova senha?")
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.center)
            }
            Spacer()
            textFieldsView
            
            buttonDesconectAccount
            
            Spacer()
            buttonResetPassword
            Spacer()
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}

extension EditPasswordView {
    private var buttonResetPassword: some View {
        VStack {
            PJButton(title: "Redefinir Senha", buttonType: .primaryType) {
                viewModel.editPassword(value: viewModel.user.password)
            }
        }
        .alert(isPresented: viewModel.isPresentingAlert, content: {
            Alert(localizedError: viewModel.activeError!)
        })
//        .alert(isPresented: $viewModel.cancel) {
//            Alert(title: Text("Alteração de Senha"),
//                  message: Text("Senha alterada com sucesso"),
//                  primaryButton: .cancel(),
//                  secondaryButton: .destructive(
//                    Text("OK"),
//                    action: {
//                        if viewModel.resetPasswordAction {
//                            self.isLoginView = false
//                        } else {
//                            self.isLoginView = true
//                        }
//                    }
//                  )
//            )
//        }
        .padding([.leading,.trailing], 60)
    }
    
    private var textFieldsView: some View {
        VStack(spacing: 10) {
            PJTextFieldView(error: viewModel.messageErrorPassword,
                            errorValidation: viewModel.isValidPassword,
                            title: "Senha",
                            placeholder: "Digite sua senha",
                            textContentType: .password,
                            text: $viewModel.user.password)
            .padding(.bottom, 20)
            
            PJTextFieldView(error: viewModel.messageErrorPasswordMatch,
                            errorValidation: viewModel.matchPass,
                            title: "Confirme sua senha",
                            placeholder: "Digite sua senha",
                            textContentType: .password,
                            text: $viewModel.user.passwordMatch)
        }
    }
    
    private var buttonDesconectAccount: some View {
        HStack {
            Button(action: {
                viewModel.isCheckBox.toggle()
            }) {
                Image(viewModel.isCheckBox ? "ic_checkBox_select" : "ic_checkBox_clear")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            
            Text("É necessário que todos os dispositivos acessem sua conta com a nova senha?")
                .font(.footnote)
                .fontWeight(.light)
                .multilineTextAlignment(.leading)
        }
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
