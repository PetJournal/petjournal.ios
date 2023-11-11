//
//  SideViewContent.swift
//  petJournal
//
//  Created by Marcylene Barreto on 10/11/23.
//

import SwiftUI

struct SideViewContent: View {
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        ZStack {
            VStack(alignment: .trailing) {
                SideMenuTopView()
                
                VStack {
                    Text("Side Menu")
                        .foregroundColor(Color.white)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .frame(maxWidth: .infinity)
            .background(.gray)
        }
    }
    
    @ViewBuilder
    private func SideMenuTopView() -> some View {
        VStack {
            HStack {
                Button {
                    presentSideMenu.toggle()
                } label: {
                    Image(systemName: "x.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(Color.white)
                }
                .frame(width: 30, height: 30)
                Spacer()

            }
        }
        .frame(maxWidth: .infinity)
        .padding([.leading, .top], 40)
        .padding(.bottom, 30)
    }
}
