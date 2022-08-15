//
//  AppDIContainer.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/08/12.
//

import UIKit

final class AppDIContainer {
    static func start() -> UITabBarController {
        let tabBarController = UITabBarController()
        let homeNavigationController = UINavigationController(rootViewController: HomeDIContainer.makeHomeViewController())
        let wishListNavigationController = UINavigationController()
        let loginNavigationController = UINavigationController()
        
        tabBarController.viewControllers = [
            homeNavigationController,
            wishListNavigationController,
            loginNavigationController
        ]
        
        tabBarController.tabBar.backgroundColor = UIColor.greyBackground
        tabBarController.tabBar.tintColor = .black
        
        homeNavigationController.tabBarItem = .init(
            title: "검색",
            image: UIImage(named: "find"),
            tag: 1
        )
        
        wishListNavigationController.tabBarItem = .init(
            title: "위시리스트",
            image: UIImage(named: "heart"),
            tag: 2
        )
        
        loginNavigationController.tabBarItem = .init(
            title: "로그인",
            image: UIImage(named: "person"),
            tag: 3
        )

        return tabBarController
    }
}
