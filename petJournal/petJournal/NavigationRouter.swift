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
    case petRegister
    case taskList(tasks: [PetTaskModel], filterType: TaskType)
}

@MainActor
class NavigationRouter: ObservableObject {
    @Published var path = NavigationPath()
    
    func navigate(to route: Route) {
        path.append(route)
    }
    
    func navigateBack() {
        path.removeLast()
    }
    
    func popToRoot() {
        path.removeLast(path.count)
    }
}
