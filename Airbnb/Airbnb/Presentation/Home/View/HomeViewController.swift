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

class HomeViewController: UIViewController, InjectViewModel {
    private var viewModel: HomeViewModelProtocol?
    private var dataSource: DataSource?

    private let titleView = SearchBarView()
    private let underLine = UIView()
    
    private lazy var collectionView: UICollectionView = {
        let layout = LayoutFactory.creatLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .greyBackground
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
    
    private let label: UILabel = {
        let label = UILabel()
        return label
    }()
    
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
        view.backgroundColor = .white
        navigationController?.isNavigationBarHidden = true
        underLine.backgroundColor = .line
        configureDataSource(in: collectionView)
    }
    
    private func layout() {
        view.addSubview(titleView)
        view.addSubview(label)
        view.addSubview(underLine)
        view.addSubview(collectionView)
        view.addSubview(mapButton)
        
        titleView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
        
        label.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        underLine.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(1)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(underLine.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(view.safeAreaLayoutGuide)
        }

        mapButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            $0.width.equalTo(110)
            $0.height.equalTo(45)
        }
    }
    
    private func bind() {
        viewModel?.testLabel.bind { [weak self] _ in
            guard let `self` = self else { return }
            self.label.text = "레이블~~~~"
        }
    }
}

// MARK: - ViewModel 생성 및 주입
extension HomeViewController {
    static func creat(with viewModel: HomeViewModelProtocol) -> UIViewController {
        let viewController = HomeViewController()
        viewController.viewModel = viewModel
        return viewController
    }
    
    private func configureDataSource(in collectionView: UICollectionView) {
        let registration = CollectionViewRegistration()
        
        let suggestCellRegistration = registration.createSuggestCellRegister()
        let cityCellRegistration = registration.createCityCellRegister()
        
        let dataSource: DataSource? = .init(collectionView: collectionView) { collectionView, indexPath, item in
            // indexPath의 Section을 이용해서 우리가 정의한 SectionType(Enum)을 만든다.
            guard let section = SectionType(rawValue: indexPath.section) else { return nil }
            
            switch section {
            case .suggest:
                guard let item = item as? Suggest else { return nil }
                return collectionView.dequeueConfiguredReusableCell(
                    using: suggestCellRegistration,
                    for: indexPath,
                    item: item)
                
            case .city:
                guard let item = item as? City else { return nil }
                return collectionView.dequeueConfiguredReusableCell(
                    using: cityCellRegistration,
                    for: indexPath,
                    item: item)
            }
        }
        self.dataSource = dataSource
    }
    
    private func snapShot(item: ItemType) {
        var suggestSnapShot = NSDiffableDataSourceSectionSnapshot<AnyHashable>()
        suggestSnapShot.append([item.suggest])
        
        var citySnapShot = NSDiffableDataSourceSectionSnapshot<AnyHashable>()
        citySnapShot.append([item.city])
        
        dataSource?.apply(suggestSnapShot, to: .suggest)
        dataSource?.apply(citySnapShot, to: .city)
    }
}
