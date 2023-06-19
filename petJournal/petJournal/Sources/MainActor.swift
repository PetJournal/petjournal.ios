//
//  MainActor.swift
//  petJournal
//
//  Created by Marcylene Barreto on 27/05/23.
//

import SwiftUI

struct MainActor: View {
    @EnvironmentObject var vm: SessionManager
    
    var body: some View {
        NavigationView {
            if vm.userSession.hasSession {
                Text("Tem Sessao ativa")
            } else {
                AccessAccountView(viewModel: AccessAccountViewModel(service: AccessAccountService()))
            }
        }
    }
}
