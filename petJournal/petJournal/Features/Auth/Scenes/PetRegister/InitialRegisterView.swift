//
//  InitialRegisterScreen.swift
//  petJournal
//
//  Created by Marcylene Barreto on 02/07/23.
//

import SwiftUI

struct InitialRegisterView: View {
    @EnvironmentObject var baseNavigationModel: BaseNavigationModel
    
    var body: some View {
        NavigationView {
            VStack {
                Text("Olá Camila")
                    .font(.system(size: 18))
                    .bold()
                    .foregroundColor(Color.theme.petPrimary)
                    .padding(.top, 20)

                Text("Sabemos o quanto o seu pet é especial, e estamos muito animados em recebê-los, venha se juntar a nossa comunidade de amantes de Pets, para melhor aproveitar a nossa plataforma.")
                    .font(.subheadline)
                    .multilineTextAlignment(.center)
                    .foregroundColor(Color.theme.petPrimary)
                    .padding(.top, 20)

                VStack {
                    Image("staticImg-register")
                        .resizable()
                        .scaledToFit()
                        .padding(.bottom, 20)

                    PJButton(title: "Cadastrar", buttonType: .primaryType) {
                        baseNavigationModel.pushMain(view: Text("Species View"))
                    }
                    
                }
                .padding(20)
            }
            .padding(20)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .background(Color.theme.petWhite)
            .navigationTitle("Cadastro Pet")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarColor(backgroundColor: Color.theme.petWhite, titleColor: Color.theme.petPrimary)
        }
        .ignoresSafeArea(.all, edges: .top)
    }
}
