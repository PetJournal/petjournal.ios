//
//  EditPasswordView.swift
//  petJournal
//
//  Created by Marcylene Barreto on 15/05/23.
//

import SwiftUI

struct EditPasswordView: View {
    @StateObject var viewModel: EditPasswordViewModel
    @State var isPasswordPrimary: Bool = false
    @State var isPasswordSecudary: Bool = false
    @State var isRemember = true
    
    var body: some View {
        NavigationView {
            VStack {
                Image("pet_logoPrimary")
                    .resizable()
                    .frame(width: 148, height: 128)
                
                Spacer()
                
                VStack(spacing: 10) {
                    Text("Criar uma nova senha?")
                        .font(.title2)
                        .multilineTextAlignment(.center)
                }
                Spacer()
                VStack(spacing: 10) {
                    CustomTextField(isPasswordVisible: $isPasswordPrimary, text: $viewModel.user.password, hint: "Your password", prompt: "", title: "Nova Senha")
                    
                    CustomTextField(isPasswordVisible: $isPasswordSecudary, text: $viewModel.user.passwordMatch, hint: "Repeat your password", prompt: "Error", title: "Confirme nova senha")
                }
                
                HStack {
                    Button(action: {
                        isRemember.toggle()
                    }) {
                        Image(isRemember ? "ic_checkBox_clear" : "ic_checkBox_select")
                            .resizable()
                            .frame(width: 20, height: 20)
                    }
                    
                    Text("É necessário que todos os dispositivos acessem sua conta com a nova senha?")
                        .font(.footnote)
                        .fontWeight(.light)
                        .multilineTextAlignment(.leading)
                }
                Spacer()
                VStack {
                    PJButton(title: "Redefinir Senha", buttonType: .primaryType) {
                        viewModel.checkMatchPassword()
                    }
                    .disabled(viewModel.passwordsMatch)
                    .opacity(viewModel.passwordCheck ? 0.5 : 1)
                }
                .padding([.leading,.trailing], 60)
                Spacer()
            }
            .padding()
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .alert("Redefinir Senha", isPresented: $viewModel.cancel) {
            } message: {
                switch viewModel.error {
                case .noMatch:
                    Text("Your passwords is different!")
                case .confirm:
                    Text("Senha alterada, faça login novamente!")
                }
            }
        }
    }
}
