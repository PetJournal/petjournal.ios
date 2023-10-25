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
            Text("createaccount-message")
            
            Button(action: { action() }) {
                Text("createaccount-button-message")
            }
        }
    }
}
