//
//  HomeDIContainer.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/08/04.
//

import UIKit

final class HomeDIContainer {
    static func makeHomeViewController() -> UIViewController {
        let viewModel = HomeViewModel()
        return HomeViewController.creat(with: viewModel)
    }
}
