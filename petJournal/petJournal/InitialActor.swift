//
//  MainActor.swift
//  petJournal
//
//  Created by Marcylene Barreto on 27/05/23.
//

import SwiftUI

struct InitialActor: View {
    @EnvironmentObject var sessionManager: SessionManager
    
    var body: some View {
        NavigationView {
            switch sessionManager.statusLogin {
            case .signIn: TabBarView()
            case .signOut: AccessAccountView(viewModel: AccessAccountViewModel(service: AccessAccountService()))
            case .unknown: LoadingView()
            }
        }
    }
}
