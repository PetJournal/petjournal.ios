import SwiftUI

struct InitialActor: View {
    @EnvironmentObject var sessionManager: SessionManager
    @StateObject private var router = NavigationRouter()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            Group {
                switch sessionManager.statusLogin {
                case .signIn: TabBarView()
                case .signOut: AccessAccountView(viewModel: AccessAccountViewModel(service: AccessAccountService()))
                case .unknown: LoadingView()
                }
            }
            .navigationDestination(for: Route.self) { route in
                view(for: route)
            }
        }
        .environmentObject(router)
    }

    @ViewBuilder
    private func view(for route: Route) -> some View {
        switch route {
        // Autenticação
        case .accessAccount:
            AccessAccountView(viewModel: .init(service: AccessAccountService()))
        case .createAccount:
            CreateAccountView()
        case .forgotPassword:
            InputEmailView(viewModel: .init(service: ForgotPasswordService()))
        case .waitingCode:
            WaitingCodeView()
        case .editPassword:
            EditPasswordView(viewModel: .init())
        
        // Pets
        case .petList:
            PetListView()
        case .petProfile(let pet):
            PetProfileView(pet: pet)
        case .petRegister:
            PetRegisterView()
        
        // Tarefas
        case .taskList(let tasks, let filterType):
            TaskListView(tasks: tasks, filterType: filterType)
        
        // Home
        case .home:
            PetHomeView()
        }
    }
}
