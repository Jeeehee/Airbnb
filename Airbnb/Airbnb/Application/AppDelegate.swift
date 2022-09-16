//
//  AppDelegate.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/07/07.
//

import GoogleMaps
import GooglePlaces
import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        GMSServices.provideAPIKey("AIzaSyDaYW2u3x9tAAk_N22v2DNTo04qhWqyjis")
        GMSPlacesClient.provideAPIKey("AIzaSyDaYW2u3x9tAAk_N22v2DNTo04qhWqyjis")
        GoogleManager.shared.getCurrentPlace()
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
}
