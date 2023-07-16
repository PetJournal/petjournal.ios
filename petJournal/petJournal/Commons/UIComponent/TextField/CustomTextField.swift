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
    var placeholder: String
    var prompt: String
    var title: String
    
    var body: some View {
        HStack {
            if isPasswordVisible {
                TextFieldView(
                    title: title,
                    placeholder: placeholder,
                    text: $text,
                    prompt: prompt
                )
            } else {
                SecuredTextFieldView(
                    title: title,
                    placeholder: placeholder,
                    text: $text,
                    prompt: prompt
                )
            }
        }
        .overlay(
            Image(systemName: isPasswordVisible ? "eye.fill" : "eye.slash.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 16, height: 16)
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
        CustomTextField(isPasswordVisible: .constant(false), text: .constant(""), placeholder: "", prompt: "Your password", title: "Password")
    }
}
