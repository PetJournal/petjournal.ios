import SwiftUI

struct HomePageView: View {
    @State var presentSideMenu = false
    @State var seeMoreServices = false
    
    let rowSpacing: CGFloat = 10
    var gridLayout: [GridItem] {
        return Array(repeating: GridItem(.flexible(), spacing: rowSpacing), count: 2)
    }
    
    var body: some View {
        ZStack {
            Color.theme.petWhite.edgesIgnoringSafeArea(.all)
            
            VStack {
                scrollViewHome
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
            .padding(.top, UIApplication
                .shared
                .connectedScenes
                .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
                .first { $0.isKeyWindow }?.safeAreaInsets.top)
            .overlay(alignment: .top) {
                ZStack {
                    HStack {
                        Text("Olá, Camila")
                            .foregroundColor(Color.theme.petBlack)
                            .font(.title2)
                        
                        Spacer()
                        
                        Button {
                            presentSideMenu.toggle()
                        } label: {
                            Image("menu-burger")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(Color.theme.petBlack)
                        }
                        .frame(width: 30, height: 30)
                    }
                    .padding(.horizontal, 20)
                }
                .frame(maxWidth: .infinity)
                .frame(height: 56)
                .background(Color.theme.petWhite)
                .zIndex(1)
                .shadow(radius: 0.5)
            }
            .background(Color.theme.petWhite)
            sideMenu()
        }
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    private func sideMenu() -> some View {
        SideMenuView(isShowing: $presentSideMenu, direction: .trailing) {
            SideViewContent(presentSideMenu: $presentSideMenu)
                .frame(width: 300)
        }
    }
}

extension HomePageView {
    private var seeMore: some View {
        HStack(spacing: 10) {
            Text("Serviços")
                .foregroundColor(Color.theme.petBlack)
                .font(.subheadline)
            
            Spacer()
            
            Button {
                withAnimation(.easeInOut) {
                    seeMoreServices.toggle()
                }
            } label: {
                Text(seeMoreServices ? "Ver Menos" : "Ver mais")
                    .foregroundColor(Color.theme.petBlack)
                    .font(.caption)
                    .padding(.vertical, 4)
            }
            
        }
        .padding(.horizontal, 15)
    }
    
    private var menuService: some View {
        LazyVGrid(columns: gridLayout, spacing: 15) {
            ForEach(mock_services.prefix(4)) { serv in
                ServiceItemView(service: serv)
            }
        }
        .padding(10)
    }
    
    private var moreService: some View {
        LazyVGrid(columns: gridLayout, spacing: 15) {
            ForEach(mock_services.suffix(from: 4)) { serv in
                ServiceItemView(service: serv)
            }
        }
        .padding(10)
    }
    
    private var scrollViewHome: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 0) {
                FeatureTabView()
                    .frame(height: UIScreen.main.bounds.width / 1.945)
                    .padding(.vertical, 10)
                
                seeMore
                menuService
                
                if seeMoreServices {
                   moreService
                }
            }
        }
    }
}
