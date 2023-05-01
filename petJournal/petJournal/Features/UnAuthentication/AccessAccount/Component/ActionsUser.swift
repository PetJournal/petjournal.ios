//
//  ActionsUser.swift
//  petJournal
//
//  Created by Marcylene Barreto on 25/04/23.
//

import SwiftUI

struct ActionsUser: View {
    var action: () -> Void
    @State var isRemember = true
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    isRemember.toggle()
                }) {
                    Image(isRemember ? "ic_checkBox_clear" : "ic_checkBox_select")
                        .resizable()
                        .frame(width: 20, height: 20)
                }
                
                Text("Lembrar?")
                    .foregroundColor(.black)
                
                Spacer()
                
                Button(action: { action() }) {
                    Text("Esqueceu sua senha?")
                        .foregroundColor(.black)
                }
            }
        }
    }
}
