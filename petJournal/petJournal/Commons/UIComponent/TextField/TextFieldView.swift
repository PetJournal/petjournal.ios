//
//  TextFieldView.swift
//  petJournal
//
//  Created by Marcylene Barreto on 16/05/23.
//

import SwiftUI

struct TextFieldView: View {
    var title: String
    var placeholder: String
    @Binding var text: String
    var prompt: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 3) {
            Text(LocalizedStringKey(title))
                .foregroundColor(Color.theme.petPrimary)
                .font(.system(size: 15))
            
            TextField(LocalizedStringKey(placeholder),
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
        }
    }
}

struct TextFieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextFieldView(title: "Name", placeholder: "your name", text: .constant(""), prompt: "")
    }
}
