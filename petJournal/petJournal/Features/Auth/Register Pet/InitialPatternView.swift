//
//  InitialPatternView.swift
//  petJournal
//
//  Created by Marcylene Barreto on 02/01/24.
//

import SwiftUI

struct InitialPatternView: View {
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack(spacing: 20) {
                    Text("Olá Camila!")
                        .font(.fedokaMedium(size: .great))
                        .foregroundColor(Color.theme.petPrimary)
                    
                    Text("Sabemos o quanto o seu pet é especial, e estamos muito animados em recebê-los, venha se juntar a nossa comunidade de amantes de Pets, para melhor aproveitar a nossa plataforma.")
                        .font(.fedokaRegular(size: .great))
                        .foregroundColor(Color.theme.petPrimary)
                        .multilineTextAlignment(.center)
                        .padding(.vertical, 10)
                    
                    Image("img_initialRegisterPet")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    
                    PJButton(title: "Continuar", buttonType: .primaryType) {
                        print("Next")
                    }
                    .frame(width: geometry.size.width * 0.85)
                    
                }
                .padding(20)
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                        Text("Cadastro Pet")
                            .font(.headline)
                            .foregroundColor(Color.theme.petPrimary)
                }
            }
        }
    }
}

#Preview {
    InitialPatternView()
}
