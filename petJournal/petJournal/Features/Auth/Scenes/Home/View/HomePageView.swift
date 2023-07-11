//
//  HomePage.swift
//  petJournal
//
//  Created by Marcylene Barreto on 20/06/23.
//

import SwiftUI

struct HomePageView: View {
    @State private var seeMoreServices: Bool = false
    
    @State private var x = UIScreen.main.bounds.width - 90
    @State private var width = UIScreen.main.bounds.width + 90
    
    let rowSpacing: CGFloat = 10
    var gridLayout: [GridItem] {
        return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 2)
    }
    
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .trailing, vertical: .center)) {
            VStack(spacing: 0) {
                HStack {
                    ProfileComponentView(xMenu: $x)
                }
                .padding(.horizontal, 10)
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                .background(Color.white)
                
                scrollViewHome
                
            }
            .background(Color.theme.petWhite.ignoresSafeArea(.all, edges: .all))
            
            SideMenuView()
                .offset(x: x)
                .background(Color.theme.petBlack.opacity(x == 0 ? 0.5 : 0).ignoresSafeArea(.all, edges: .vertical))
                .onTapGesture {
                    withAnimation {
                        x = +width
                    }
                }
        }
        .gesture(DragGesture().onChanged({ (value) in
            withAnimation {
                if value.translation.width > 0 {
                    if x < 0 {
                        x = +width + value.translation.width
                    }
                } else {
                    x = value.translation.width
                }
            }
        }).onEnded({ (value) in
            withAnimation {
                if +x < width / 2 {
                    x = 0
                } else {
                    x = +width
                }
            }
        })
        )
        .ignoresSafeArea(.all, edges: .top)
    }
}

extension HomePageView {
    private var seeMore: some View {
        HStack(spacing: 10) {
            Text("Serviços")
                .foregroundColor(Color.theme.petBlack)
                .font(.subheadline)
                .fontWeight(.bold)
            
            Spacer()
            
            Button {
                withAnimation(.easeInOut) {
                    seeMoreServices.toggle()
                }
            } label: {
                Text(seeMoreServices ? "Ver Menos" : "Ver mais")
                    .font(.caption)
                    .fontWeight(.bold)
                    .padding(.vertical, 4)
            }
            
        }
        .padding(.horizontal, 15)
    }
    
    private var menuService: some View {
        LazyVGrid(columns: gridLayout, spacing: 15) {
            ForEach(mock_services) { serv in
                ServiceItemView(service: serv)
            }
        }
        .padding(15)
    }
    
    private var scrollViewHome: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                FeatureTabView()
                    .frame(height: UIScreen.main.bounds.width / 1.945)
                    .padding(.vertical, 10)
                
                seeMore
                
                menuService
            }
        }
    }
}