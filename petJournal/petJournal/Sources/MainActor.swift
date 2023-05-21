//
//  MainActor.swift
//  petJournal
//
//  Created by Marcylene Barreto on 19/05/23.
//

import SwiftUI

struct MainActor: View {
    @EnvironmentObject var vm: SessionVM
    
    var body: some View {
        NavigationView {
            switch vm.singState {
            case .signedIn:
                HomeView()
            case .signedOut:
                AccessAccountView(viewModel: AccessAccountViewModel(service: AccessAccountService()))
            case .unknown: Text("")
            }
        }
    }
}
