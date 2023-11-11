//
//  ProfileComponent.swift
//  petJournal
//
//  Created by Marcylene Barreto on 20/06/23.
//

import SwiftUI

struct ProfileComponentView: View {
//    @EnvironmentObject private var tabViewModel: TabBarViewModel
    @EnvironmentObject private var homeViewModel: HomeViewModel
    @Binding var xMenu: CGFloat
    
    var body: some View {
        HStack {
            Text("Olá, Camila")
                .font(.title2)
            Spacer()
            sideMenu
        }
        .padding(.horizontal)
    }
}

extension ProfileComponentView {
    private var sideMenu: some View {
        Button {
            withAnimation {
                xMenu = 0
            }
        } label: {
            Image("menu-burger")
                .resizable()
                .frame(width: 30, height: 30)
        }
        .padding()
        .shadow(color: .gray.opacity(0.2), radius: 5, x: 0, y: 2)
    }
}
