import SwiftUI

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
