//
//  CustomTextField.swift
//  petJournal
//
//  Created by Marcylene Barreto on 16/05/23.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var isPasswordVisible: Bool
    @Binding var text: String
    var hint: String
    var prompt: String
    var title: String
    
    var body: some View {
        HStack {
            if isPasswordVisible {
                TextFieldView(
                    title: title,
                    placeholder: hint,
                    text: $text,
                    prompt: prompt
                )
            } else {
                SecuredTextFieldView(
                    title: title,
                    placeholder: hint,
                    text: $text,
                    prompt: prompt
                )
            }
        }
        .overlay(
            Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
                .foregroundColor(Color.gray.opacity(0.7))
                .padding()
                .onTapGesture {
                    isPasswordVisible.toggle()
                }
            ,alignment: .trailing
        )
    }
}

struct CustomTextField_Previews: PreviewProvider {
    static var previews: some View {
        CustomTextField(isPasswordVisible: .constant(false), text: .constant(""), hint: "", prompt: "Your password", title: "Password")
    }
}
