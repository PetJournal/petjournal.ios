// InitialActor.swift
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
                switch route {
                case .accessAccount:
                    AccessAccountView(viewModel: AccessAccountViewModel(service: AccessAccountService()))
                case .createAccount:
                    CreateAccountView()
                case .forgotPassword:
                    InputEmailView(viewModel: ForgotPasswordViewModel(service: ForgotPasswordService()))
                case .waitingCode:
                    WaitingCodeView()
                case .editPassword:
                    EditPasswordView(viewModel: EditPasswordViewModel())
                case .home:
                    PetHomeView()
                case .petList:
                    PetListView()
                case .petProfile(let pet):
                    PetProfileView(pet: pet)
                case .petRegister:
                    PetRegisterView()
                case .taskList(let tasks, let filterType):
                    TaskListView(tasks: tasks, filterType: filterType)
                }
            }
        }
        .environmentObject(router)
    }
}
