//
//  SecuredTextFieldView.swift
//  petJournal
//
//  Created by Marcylene Barreto on 16/05/23.
//

import SwiftUI

struct SecuredTextFieldView: View {
    var title: String
    var placeholder: String
    @Binding var text: String
    var prompt: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(LocalizedStringKey(title))
                .foregroundColor(Color.theme.petPrimary)
                .font(.system(size: 15))
            
            SecureField(
                LocalizedStringKey(placeholder),
                text: $text
            )
            .autocapitalization(.none)
            .padding()
            .frame(maxWidth: .infinity)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color.theme.petGray300,
                            lineWidth: 2)
            )
            .shadow(color: Color.theme.petBlack.opacity(0.02), radius: 60, x: 0.0, y: 16)
            Text("")
                .foregroundColor(Color.theme.petError)
                .fixedSize(horizontal: false, vertical: true)
                .font(.caption)
                .frame(alignment: .leading)
        }
    }
}

struct SecuredTextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        SecuredTextFieldView(title: "Password", placeholder: "you password", text: .constant(""), prompt: "")
    }
}
