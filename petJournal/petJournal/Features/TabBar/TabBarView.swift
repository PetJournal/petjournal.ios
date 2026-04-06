import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var router: NavigationRouter
    @StateObject private var tabViewModel = TabBarViewModel()
    
    var body: some View {
        VStack(spacing: 0) {
            Group {
                switch tabViewModel.currentTab {
                case 0:
                    NavigationStack(path: $router.homePath) {
                        PetHomeView()
                            .navigationDestination(for: HomeRoute.self, 
                                                   destination: NavigationDestinationHandler.handleHomeNavigation)
                    }
                case 1:
                    NavigationStack(path: $router.agendaPath) {
                        TaskListView(filterType: .all)
                            .navigationDestination(for: AgendaRoute.self, 
                                                   destination: NavigationDestinationHandler.handleAgendaNavigation)
                    }
                case 2:
                    NavigationStack(path: $router.petPath) {
                        PetListView()
                            .navigationDestination(for: PetRoute.self, 
                                                   destination: NavigationDestinationHandler.handlePetNavigation)
                    }
                case 3:
                    NavigationStack(path: $router.userPath) {
                        TutorProfileView()
                            .navigationDestination(for: UserRoute.self, 
                                                   destination: NavigationDestinationHandler.handleUserNavigation)
                    }
                default:
                    NavigationStack(path: $router.homePath) {
                        PetHomeView()
                            .navigationDestination(for: HomeRoute.self, 
                                                   destination: NavigationDestinationHandler.handleHomeNavigation)
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onChange(of: tabViewModel.currentTab) { _, newTab in
                router.currentTab = newTab
            }
            .onAppear {
                router.currentTab = tabViewModel.currentTab
            }
            
            CustomTabBar(viewModel: tabViewModel)
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
            .environmentObject(NavigationRouter())
    }
}
