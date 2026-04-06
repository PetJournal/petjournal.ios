//
//  CompRememberAndForgotPassword.swift
//  petJournal
//
//  Created by Marcylene Barreto on 14/06/23.
//

import SwiftUI

struct CompRememberAndForgotPassword: View {
    @State var isRemember = true
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    isRemember.toggle()
                }) {
                    Image(isRemember ? .icCheckBoxClear : .icCheckBoxSelect)
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                
                Text("Lembrar")
                    .font(.fredokaMedium(size: .tiny))
                    .foregroundColor(Color.theme.petBlack)
                
                Spacer()
            }
        }
    }
}
