//
//  HomeViewController.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/07/07.
//

import UIKit

protocol CreateViewModel {
    static func creat(with viewModel: HomeViewModelProtocol) -> UIViewController
}

class HomeViewController: UIViewController, CreateViewModel {
    
    // ViewModel 생성 및 주입
    static func creat(with viewModel: HomeViewModelProtocol) -> UIViewController {
        let viewController = HomeViewController()
        viewController.viewModel = viewModel
        return viewController
    }
    
    private var viewModel: HomeViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .darkGray
    }
}
