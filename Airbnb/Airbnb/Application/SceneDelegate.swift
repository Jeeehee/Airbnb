//
//  SceneDelegate.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/07/07.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let startViewController = AppDIContainer.start()
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController = startViewController
        window?.makeKeyAndVisible()
    }
}
