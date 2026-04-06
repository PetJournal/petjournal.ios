import SwiftUI

struct InitialActor: View {
    @EnvironmentObject var sessionManager: SessionManager
    @StateObject private var router = NavigationRouter()
    
    var body: some View {
        Group {
            switch sessionManager.statusLogin {
            case .signIn: 
                TabBarView()
            case .signOut: 
                NavigationStack(path: $router.authPath) {
                    AccessAccountView(viewModel: AccessAccountViewModel(service: AccessAccountService()))
                        .navigationDestination(for: Route.self, destination: NavigationDestinationHandler.handleAuthNavigation)
                }
            case .unknown: 
                LoadingView()
            }
        }
        .environmentObject(router)
    }
}
