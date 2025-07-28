import SwiftUI

struct CustomTabBar: View {
    @ObservedObject var viewModel: TabBarViewModel
    
    var body: some View {
        ZStack {
            roundedBackground
            tabBar
        }
        .frame(maxWidth: .infinity, maxHeight: 70)
    }
    
    private var roundedBackground: some View {
        RoundedRectangle(cornerRadius: 25)
            .fill(Color.theme.petPrimary100)
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: -5)
            .edgesIgnoringSafeArea(.bottom)
    }
    
    private var tabBar: some View {
        HStack(alignment: .center, spacing: 0) {
            ForEach(0..<4, id: \.self) { index in
                Button(action: { viewModel.currentTab = index }) {
                    tabItem(
                        iconName: iconName(for: index),
                        title: title(for: index),
                        isSelected: viewModel.currentTab == index
                    )
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding(.horizontal, 20)
    }
    
    private func tabItem(iconName: String, title: String,
                         isSelected: Bool) -> some View {
        VStack(spacing: 4) {
            Image(iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 24, height: 24)
            
            Text(title)
                .font(.robotoSemiBold(size: .great))
        }
        .foregroundColor(isSelected ? Color.theme.petPrimary500 : Color.theme.petGray800)
        .frame(maxWidth: .infinity)
    }
    
    private func iconName(for index: Int) -> String {
        switch index {
        case 0: return ImageAsset.home.rawValue
        case 1: return ImageAsset.petsCalendar.rawValue
        case 2: return ImageAsset.paw.rawValue
        case 3: return ImageAsset.user.rawValue
        default: return ""
        }
    }
    
    private func title(for index: Int) -> String {
        switch index {
        case 0: return "Home"
        case 1: return "Agenda"
        case 2: return "Pets"
        case 3: return "Perfil"
        default: return ""
        }
    }
}

struct TabBarView: View {
    @ObservedObject private var tabViewModel = TabBarViewModel()
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabContentContainerView(tabViewModel: tabViewModel)
            CustomTabBar(viewModel: tabViewModel)
        }
    }
}

struct TabContentContainerView: View {
    @ObservedObject var tabViewModel: TabBarViewModel
    
    var body: some View {
        TabView(selection: $tabViewModel.currentTab) {
            PetHomeView()
                .environmentObject(tabViewModel)
                .tag(0)
            
            TaskListView(tasks: [])
                .tag(1)
            
            PetListView()
                .tag(2)
            
            TutorProfileView(viewModel: AccessAccountViewModel(service: AccessAccountService()))
                .tag(3)
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
