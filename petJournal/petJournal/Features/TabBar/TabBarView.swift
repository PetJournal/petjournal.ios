import SwiftUI

struct TabBarView: View {
    @ObservedObject private var tabViewModel = TabBarViewModel()
    
    var body: some View {
        TabView(selection: $tabViewModel.currentTab) {
            PetHomeView()
                .environmentObject(tabViewModel)
                .tabItem {
                    Label("Home", image: ImageAsset.home.rawValue)
                }
                .tag(0)
            
            Text("Agenda")
                .tabItem {
                    Label("Agenda", image: ImageAsset.petsCalendar.rawValue)
                }
                .tag(1)
            
            PetListView()
                .tabItem {
                    Label("Pets", image: ImageAsset.paw.rawValue)
                }
                .tag(2)
            
            TutorProfileView(viewModel: AccessAccountViewModel(service: AccessAccountService()))
                .tabItem {
                    Label("Perfil", image: ImageAsset.user.rawValue)
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
