/// NAVIGATION SYSTEM DOCUMENTATION
///
/// Este sistema de navegação separa o fluxo de autenticação (usuário deslogado)
/// do sistema de tabs (usuário logado), permitindo navegação independente em cada tab.
///
/// ESTRUTURA:
/// ----------
/// 1. Route: Rotas gerais (principalmente para auth)
/// 2. HomeRoute, AgendaRoute, PetRoute, UserRoute: Rotas específicas de cada tab
/// 3. NavigationRouter: Gerencia todos os paths de navegação
///
/// COMO FUNCIONA:
/// --------------
/// - Auth Flow: Usa authPath para navegação quando usuário está deslogado
/// - Tab Flow: Cada tab tem seu próprio NavigationPath independente
/// - currentTab: Rastreia qual tab está ativa para navegação automática
///
/// COMO ADICIONAR NOVAS ROTAS:
/// ----------------------------
/// 1. Para Auth (usuário deslogado):
///    - Adicione case em Route enum
///    - Adicione handling em InitialActor.handleAuthNavigation
///    - Use router.navigateAuth(to: .novaRota)
///
/// 2. Para Tabs (usuário logado):
///    - Adicione case no enum da tab específica (ex: HomeRoute)
///    - Adicione handling na função correspondente do TabBarView (ex: handleHomeNavigation)
///    - Adicione mapeamento em NavigationRouter.navigate(to:)
///    - Use router.navigate(to: .novaRota) - detecta tab automaticamente
///
/// EXEMPLO - Adicionando nova rota "Settings" na tab User:
/// --------------------------------------------------------
/// 1. enum UserRoute: Hashable {
///      case petProfile(pet: PetModel)
///      case settings  // <- Nova rota
///    }
///
/// 2. Em TabBarView.handleUserNavigation:
///      case .settings:
///          SettingsView()  // <- Nova view
///
/// 3. Em NavigationRouter.navigate(to:):
///      case (3, .settings): userPath.append(UserRoute.settings)  // <- Novo mapeamento
///
/// 4. Para navegar:
///      router.navigate(to: .settings)  // <- Uso
///
/// NAVEGAÇÃO ENTRE TABS:
/// ---------------------
/// - Cada tab mantém seu próprio estado de navegação
/// - Trocar de tab preserva o estado de navegação de cada uma
/// - CustomNavigationBar detecta automaticamente qual tab usar para voltar

import SwiftUI

enum Route: Hashable {
    case accessAccount
    case createAccount
    case forgotPassword
    case waitingCode
    case editPassword
    case home
    case petList
    case petProfile(pet: PetModel)
    case petRegister(pet: PetModel?)
    case taskList(tasks: [PetTaskModel], filterType: TaskType)
}

enum HomeRoute: Hashable {
    case petProfile(pet: PetModel)
    case petRegister
    case taskList(tasks: [PetTaskModel], filterType: TaskType)
}

enum AgendaRoute: Hashable {
    case petProfile(pet: PetModel)
    case taskList(tasks: [PetTaskModel], filterType: TaskType)
}

enum PetRoute: Hashable {
    case petProfile(pet: PetModel)
    case petRegister(pet: PetModel?)
}

enum UserRoute: Hashable {
    case petProfile(pet: PetModel)
}

@MainActor
class NavigationRouter: ObservableObject {
    
    @Published var authPath = NavigationPath()
    @Published var homePath = NavigationPath()
    @Published var agendaPath = NavigationPath()
    @Published var petPath = NavigationPath()
    @Published var userPath = NavigationPath()
    
    @Published var currentTab: Int = 0
    
    // MARK: - Auth Navigation Methods
    func navigateAuth(to route: Route) {
        authPath.append(route)
    }
    
    func navigateBackAuth() {
        guard !authPath.isEmpty else { return }
        authPath.removeLast()
    }
    
    // MARK: - Tab Navigation Methods
    func navigate(to route: Route) {
        switch (currentTab, route) {
        case (0, .petProfile(let pet)): homePath.append(HomeRoute.petProfile(pet: pet))
        case (0, .petRegister): homePath.append(HomeRoute.petRegister)
        case (0, .taskList(let tasks, let filterType)): homePath.append(HomeRoute.taskList(tasks: tasks, filterType: filterType))
        case (1, .petProfile(let pet)): agendaPath.append(AgendaRoute.petProfile(pet: pet))
        case (1, .taskList(let tasks, let filterType)): agendaPath.append(AgendaRoute.taskList(tasks: tasks, filterType: filterType))
        case (2, .petProfile(let pet)): petPath.append(PetRoute.petProfile(pet: pet))
        case (2, .petRegister(let pet)): petPath.append(PetRoute.petRegister(pet: pet))
        case (3, .petProfile(let pet)): userPath.append(UserRoute.petProfile(pet: pet))
        default: break
        }
    }
    
    func navigateBack() {
        switch currentTab {
        case 0:
            guard !homePath.isEmpty else { return }
            homePath.removeLast()
        case 1:
            guard !agendaPath.isEmpty else { return }
            agendaPath.removeLast()
        case 2:
            guard !petPath.isEmpty else { return }
            petPath.removeLast()
        case 3:
            guard !userPath.isEmpty else { return }
            userPath.removeLast()
        default: break
        }
    }
    
    func popToRoot() {
        switch currentTab {
        case 0: homePath.removeLast(homePath.count)
        case 1: agendaPath.removeLast(agendaPath.count)
        case 2: petPath.removeLast(petPath.count)
        case 3: userPath.removeLast(userPath.count)
        default: break
        }
    }
}
