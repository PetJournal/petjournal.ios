//
//  ComponentPrivacy.swift
//  petJournal
//
//  Created by Marcylene Barreto on 25/05/23.
//

import SwiftUI

struct ComponentPrivacy: View {
    @State var isRemember: Bool
    var user: UserModel
    var action: () -> Void
    
    var body: some View {
        HStack {
            Button(action: {
                isRemember.toggle()
            }) {
                Image(isRemember ? "ic_checkBox_select" : "ic_checkBox_clear")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            Button(action: self.action) {
                Text("Eu concordo com a política de privacidade")
                    .foregroundColor(.black)
                    .font(.system(size: 12))
            }
        }
    }
}
