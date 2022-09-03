//
//  HomeCoordinator.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/08/04.
//

import UIKit

final class HomeCoordinator {
    static func makeHomeViewController() -> UIViewController {
        let viewModel = HomeViewModel()
        return HomeViewController.creat(with: viewModel)
    }
}
