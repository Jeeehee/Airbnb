import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let startViewController = AppCoordinator.start()
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController = startViewController
        window?.makeKeyAndVisible()
    }
}
