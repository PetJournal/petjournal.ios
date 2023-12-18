//
//  ComponentPrivacy.swift
//  petJournal
//
//  Created by Marcylene Barreto on 25/05/23.
//

import SwiftUI

struct ComponentPrivacy: View {
    var action: () -> Void
    @EnvironmentObject var viewModel: CreateAccountViewModel
    
    var body: some View {
        HStack {
            Button(action: {
                viewModel.isCheckBox.toggle()
            }) {
                Image(viewModel.isCheckBox ? "ic_checkBox_select" : "ic_checkBox_clear")
                    .resizable()
                    .frame(width: 20, height: 20)
            }
            Button(action: self.action) {
                Text("Eu concordo com a política de privacidade")
                    .foregroundColor(Color.black)
                    .font(.fedokaMedium(size: .tiny))
            }
        }
    }
}
