//
//  EditPasswordView.swift
//  petJournal
//
//  Created by Marcylene Barreto on 14/06/23.
//

import SwiftUI

struct EditPasswordView: View {
    @StateObject var viewModel: EditPasswordViewModel
    @State private var isPasswordPrimary: Bool = false
    @State private var isPasswordSecudary: Bool = false
    @State private var isRemember = true
    
    var body: some View {
        
        VStack {
            Image("pet_logoPrimary")
                .resizable()
                .frame(width: 148, height: 128)
            
            Spacer()
            
            VStack(spacing: 10) {
                Text("Criar uma nova senha?")
                    .font(.title2)
                    .bold()
                    .multilineTextAlignment(.center)
            }
            Spacer()
            VStack(spacing: 10) {
                CustomTextField(isPasswordVisible: $isPasswordPrimary, text: $viewModel.user.password, placeholder: "Digite uma nova senha", prompt: viewModel.invalidPassword, title: "Nova Senha")
                
                CustomTextField(isPasswordVisible: $isPasswordSecudary, text: $viewModel.user.passwordMatch, placeholder: "Confirme sua nova senha", prompt: viewModel.errorPasswordMatch, title: "Confirme nova senha")
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
                    viewModel.editPassword(value: viewModel.user.password)
                }
                .disabled(!viewModel.passwordCheck)
                .opacity(viewModel.passwordCheck ? 1 : 0.5)
            }
            .padding([.leading,.trailing], 60)
            Spacer()
        }
        .padding()
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}
