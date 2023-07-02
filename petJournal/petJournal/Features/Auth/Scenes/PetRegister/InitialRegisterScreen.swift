//
//  InitialRegisterScreen.swift
//  petJournal
//
//  Created by Marcylene Barreto on 02/07/23.
//

import SwiftUI

struct InitialRegisterScreen: View {
    @State private var isRegister: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                VStack(spacing: 15) {
                    Text("Olá Camila")
                        .font(.system(size: 18))
                        .bold()
                        .foregroundColor(Color.theme.petPrimary)
                    
                    Text("Sabemos o quanto o seu pet é especial, e estamos muito animados em recebê-los, venha se juntar a nossa comunidade de amantes de Pets, para melhor aproveitar a nossa plataforma.")
                        .font(.subheadline)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color.theme.petPrimary)
                }
                
                Image("staticImg-register")
                    .resizable()
                    .scaledToFit()
                
                registerPetView
                PJButton(title: "Cadastrar", buttonType: .primaryType) {
                    self.isRegister = true
                }
                .frame(width: 202)
            }
            .padding(20)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Cadastro pet")
            .navigationBarColor(backgroundColor: Color.theme.petWhite, titleColor: Color.theme.petPrimary)
        }
    }
}

extension InitialRegisterScreen {
    private var registerPetView: some View {
        NavigationLink(
            destination:
                Text("Register user")
                .navigationBarHidden(true),
            isActive: self.$isRegister) {EmptyView()}
            .isDetailLink(false)
            .navigationBarHidden(true)
    }
}
