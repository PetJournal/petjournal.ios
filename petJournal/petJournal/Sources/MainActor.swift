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
            switch vm.statusLogin {
            case .signIn: TabBarView()
            case .signOut: AccessAccountView(viewModel: AccessAccountViewModel(service: AccessAccountService()))
            case .unknown: ProgressView("Loading").font(.footnote)
            }
        }
    }
}
