//
//  TabBarView.swift
//  petJournal
//
//  Created by Marcylene Barreto on 20/06/23.
//

import SwiftUI

struct TabBarView: View {
    @ObservedObject private var tabViewModel = TabBarViewModel()
    @State private var presentSideMenu = -UIScreen.main.bounds.width + 90
    
    var body: some View {
        TabView(selection: $tabViewModel.currentTab) {
            HomePageView()
                .environmentObject(tabViewModel)
                .tabItem {
                    Label("Home", image: "ic_home")
                }
                .tag(0)
            
            Text("Funcionalidade inativa no momento")
                .tabItem {
                    Label("Pet", image: "ic_pets")
                }
                .tag(1)
            
            Text("Funcionalidade inativa no momento")
                .tabItem {
                    Label("User", image: "ic_user")
                }
                .tag(2)
        }
        .withDefaultTabBar(backgroundColor: Color.theme.petPrimary, selectItem: Color.theme.petCTA)
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
