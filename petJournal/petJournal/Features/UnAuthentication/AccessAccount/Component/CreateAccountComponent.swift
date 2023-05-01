//
//  CreateAccountComponent.swift
//  petJournal
//
//  Created by Marcylene Barreto on 25/04/23.
//

import SwiftUI

struct CreateAccountComponent: View {
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
