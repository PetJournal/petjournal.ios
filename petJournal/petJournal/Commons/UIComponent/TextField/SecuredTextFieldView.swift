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
            .padding(.horizontal)
            .frame(maxWidth: .infinity, maxHeight: 50)
            .background(Color.theme.petWhite)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.theme.petGray800,
                            lineWidth: 2)
            )
            Text(prompt)
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
