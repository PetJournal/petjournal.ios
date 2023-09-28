//
//  SideMenuView.swift
//  petJournal
//
//  Created by Marcylene Barreto on 20/06/23.
//

import SwiftUI

struct SideMenuView: View {
    
    @State  var showMenu = false
    @StateObject var vm = SessionManager()
    @State  var showAlert = false
    @StateObject var viewModel: AccessAccountViewModel
    
     var edges = UIApplication.shared.windows.first?.safeAreaInsets
     var menus = ["Profile", "Serviços", "Notificações", "Pets"]
    
    var body: some View {
        HStack(spacing: 0) {
            Spacer()
            VStack(alignment: .center) {
                Image("pet_logoBlack")
                    .resizable()
                    .frame(width: 60, height: 60)
                    .background(Color.theme.petWhite)
                    .clipShape(Circle())
                
                HStack(alignment: .top, spacing: 12) {
                    VStack(alignment: .trailing, spacing: 12) {
                        Text("Camila Queiroz")
                            .font(.title3)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Text("cmz@petjournal.com")
                            .foregroundColor(.gray)
                    }
                }
                
                Divider()
                    .padding(.top)
                
                VStack(alignment: .center) {
                    ForEach(menus, id: \.self) { menu in
                        MenuButton(title: menu)
                    }
                }
                
                Divider()
                    .padding(.top)
                
                Button {
                    showAlert = true
                } label: {
                    Text("Logout")
                        .foregroundColor(Color.white)
                }
                .actionSheet(isPresented: $showAlert) {
                    ActionSheet(title: Text("Deseja realmente sair?"), buttons: [
                        .cancel(Text("Cancelar")) { },
                        .destructive(Text("Sair")) {
                            viewModel.logout()
                        }
                    ])
                }

                Spacer()
                
            }
            .padding(.horizontal, 20)
            .padding(.top, edges!.top == 0 ? 15 : edges?.top)
            .padding(.bottom, edges!.bottom == 0 ? 15 : edges?.bottom)
            .frame(width: UIScreen.main.bounds.width - 115)
            .background(Color.theme.petPrimary)
            .ignoresSafeArea(.all, edges: .vertical)
        }
    }
}

struct MenuButton: View {
    var title: String
    
    var body: some View {
        HStack(spacing: 15) {
            Image(title)
                .resizable()
                .renderingMode(.template)
                .frame(width: 24, height: 24)
                .foregroundColor(.gray)
            
            Text(title)
                .foregroundColor(.gray)
            
            Spacer(minLength: 0)
        }
        .padding(.vertical, 12)
    }
}
