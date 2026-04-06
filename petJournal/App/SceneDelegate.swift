import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
        
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        let navigationView = InitialActor()
            .environmentObject(SessionManager.shared)
            .onAppear {
                SessionManager.shared.statusLogin = SessionManager.shared.isAuthenticated ? .signIn : .signOut
            }
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = UIHostingController(rootView: navigationView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }
}

