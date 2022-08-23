//
//  HomeViewController.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/07/07.
//

import UIKit
import SnapKit

protocol InjectViewModel {
    static func creat(with viewModel: HomeViewModelProtocol) -> UIViewController
}

class HomeViewController: UIViewController {
    private var viewModel: HomeViewModelProtocol?
    private let diffableDataSourceManager = DiffableDataSourceManager()
    private let searchView = SearchBarView()
    private let underLine = UIView()
    
    private lazy var collectionView: UICollectionView = {
        let layout = LayoutFactory.creatLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    private let mapButton: ButtonWithImageAndTitle = {
        let button = ButtonWithImageAndTitle()
        button.layer.cornerRadius = 22
        button.backgroundColor = .mapButton
        var titleAttribute = AttributedString(.init(Text.mapButtonText.text))
        titleAttribute.font = .init(name: NotoSans.medium.name, size: 15)
        button.configuration?.attributedTitle = titleAttribute
        button.setImage(UIImage(named: "map"), for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        diffableDataSourceManager.configureDataSource(in: collectionView)
        addActionOfButton()
        
        attribute()
        layout()
        bind()
    }
    
    deinit {
        Log.debug("DeInit \(#fileID)")
    }
    
    private func attribute() {
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        underLine.backgroundColor = .line
        searchView.searchBardelegate = self
    }
    
    private func layout() {
        view.addSubview(searchView)
        view.addSubview(underLine)
        view.addSubview(collectionView)
        view.addSubview(mapButton)
        
        searchView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
        
        underLine.snp.makeConstraints {
            $0.top.equalTo(searchView.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(underLine.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.height.equalTo(view.safeAreaLayoutGuide)
        }

        mapButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            $0.width.equalTo(110)
            $0.height.equalTo(45)
        }
    }
    
    private func bind() {
        viewModel?.output.sectionTitle.bind { [weak self] text in
            guard !text.isEmpty else { return }
            self?.diffableDataSourceManager.getSectionTitle(text: text)
        }
        
        viewModel?.output.items.bind { [weak self] item in
            self?.diffableDataSourceManager.snapShot(item: item)
        }
    }
    
    private func addActionOfButton() {
        mapButton.addAction(.init(handler: { _ in
            let nextVieController = MapViewController()
            self.navigationController?.pushViewController(nextVieController, animated: true)
        }), for: .touchUpInside)
    }
}

// MARK: - ViewModel 생성 및 주입
extension HomeViewController: InjectViewModel {
    static func creat(with viewModel: HomeViewModelProtocol) -> UIViewController {
        let viewController = HomeViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}

extension HomeViewController: SearchBarDelegate {
    func didBeginEditing(isStartEditing: Bool) {
        if isStartEditing {
            let nextVieController = SearchBarViewController()
            self.navigationController?.pushViewController(nextVieController, animated: true)
        }
    }
}
