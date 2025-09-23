/// NavigationDestinationHandler - Centraliza toda a lógica de navegação
/// ====================================================================
///
/// Responsável por:
/// - Mapear rotas para suas respectivas views
/// - Manter consistência entre diferentes fluxos de navegação
/// - Facilitar manutenção e adição de novas rotas

import SwiftUI

struct NavigationDestinationHandler {
    
    // MARK: - Auth Navigation
    @ViewBuilder
    static func handleAuthNavigation(for route: Route) -> some View {
        switch route {
        case .accessAccount:
            AccessAccountView()
        case .createAccount:
            CreateAccountView()
        case .forgotPassword:
            InputEmailView(viewModel: ForgotPasswordViewModel(service: ForgotPasswordService()))
        case .waitingCode:
            WaitingCodeView()
        case .editPassword:
            EditPasswordView(viewModel: EditPasswordViewModel())
        default:
            EmptyView()
        }
    }
    
    // MARK: - Tab Navigation
    @ViewBuilder
    static func handleHomeNavigation(for route: HomeRoute) -> some View {
        switch route {
        case .petRegister:
            PetRegisterView()
        case .petProfile(let pet):
            PetProfileView(pet: pet)
        case .taskList(let tasks, let filterType):
            TaskListView(tasks: tasks, filterType: filterType)
        }
    }
    
    @ViewBuilder
    static func handleAgendaNavigation(for route: AgendaRoute) -> some View {
        switch route {
        case .petProfile(let pet):
            PetProfileView(pet: pet)
        case .taskList(let tasks, let filterType):
            TaskListView(tasks: tasks, filterType: filterType)
        }
    }
    
    @ViewBuilder
    static func handlePetNavigation(for route: PetRoute) -> some View {
        switch route {
        case .petRegister:
            PetRegisterView()
        case .petProfile(let pet):
            PetProfileView(pet: pet)
        }
    }
    
    @ViewBuilder
    static func handleUserNavigation(for route: UserRoute) -> some View {
        switch route {
        case .petProfile(let pet):
            PetProfileView(pet: pet)
        }
    }
}
