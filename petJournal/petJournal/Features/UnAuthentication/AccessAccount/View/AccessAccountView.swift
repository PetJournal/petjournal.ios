//
//  AccessAccountView.swift
//  petJournal
//
//  Created by Marcylene Barreto on 16/05/23.
//

import SwiftUI

struct AccessAccountView: View {
    @State private var isPasswordVisible: Bool = false
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        VStack {
            Image("pet_logoPrimary")
                .resizable()
                .frame(width: 148, height: 118)
            
            VStack(spacing: 10) {
                TextFieldView(title: "Mail", placeholder: "your Mail", text: $email, prompt: "")
                CustomTextField(isPasswordVisible: $isPasswordVisible, text: $password, hint: "your Pass", prompt: "", title: "Pass")
            }
            
            VStack {
                PJButton(title: "Entrar", buttonType: .primaryType) {
                    print("Tap button")
                }
                
                PJButton(title: "Cancelar", buttonType: .secundaryType) {
                    print("Tap button")
                }
            }
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
    }
}

struct AccessAccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccessAccountView()
    }
}
