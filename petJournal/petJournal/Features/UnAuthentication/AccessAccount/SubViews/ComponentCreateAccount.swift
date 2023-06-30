//
//  ComponentCreateAccount.swift
//  petJournal
//
//  Created by Marcylene Barreto on 14/06/23.
//

import SwiftUI

struct ComponentCreateAccount: View {
    var action: () -> Void
    
    var body: some View {
        HStack {
            Text("Não tem conta?")
            
            Button(action: { action() }) {
                Text("Inscreva-se")
            }
        }
    }
}
