//
//  TabBarView.swift
//  petJournal
//
//  Created by Marcylene Barreto on 20/06/23.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var router: NavigationRouter
    @ObservedObject private var tabViewModel = TabBarViewModel()
    
    var body: some View {
        TabView(selection: $tabViewModel.currentTab) {
            NavigationStack {
                HomePageView()
            }
            .tabItem {
                Label("Home", image: ImageAsset.home.rawValue)
            }
            .tag(0)
            
            NavigationStack {
                Text("Agenda")
            }
            .tabItem {
                Label("Agenda", image: ImageAsset.petsCalendar.rawValue)
            }
            .tag(1)
            
            NavigationStack {
                PetListView()
            }
            .tabItem {
                Label("Pet", image: ImageAsset.paw.rawValue)
            }
            .tag(2)
            
            NavigationStack {
                Text("Tutor")
            }
            .tabItem {
                Label("User", image: ImageAsset.user.rawValue)
            }
            .tag(3)
        }
        .withDefaultTabBar()
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
