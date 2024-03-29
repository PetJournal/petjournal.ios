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
        VStack(alignment: .leading, spacing: 5) {
            Text(LocalizedStringKey(title))
                .foregroundColor(Color.theme.petPrimary)
                .font(.system(size: 15))
            
            TextField(LocalizedStringKey(placeholder),
                text: $text
            )
            .autocapitalization(.none)
            .padding()
            .frame(maxWidth: .infinity)
            .background(Color.theme.petGray300)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.theme.petGray300,
                            lineWidth: 2)
            )
            .shadow(color: Color.theme.petBlack.opacity(0.05), radius: 60, x: 0.0, y: 12)
            Text("")
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
