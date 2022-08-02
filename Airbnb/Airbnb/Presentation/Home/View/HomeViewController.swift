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
        attribute()
        layout()
        bind()
    }
    
    deinit {
        Log.debug("DeInit \(#fileID)")
    }
    
    private func attribute() {
        view.backgroundColor = .darkGray
    }
    
    private func layout() {}
    
    private func bind() {}
}
