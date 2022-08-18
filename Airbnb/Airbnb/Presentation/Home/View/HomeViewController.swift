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
    private var dataSource: DataSource?
    private let registration = CollectionViewRegistration()

    private let titleView = SearchBarView()
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
    
    private let label: UILabel = {
        let label = UILabel()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        attribute()
        layout()
    }
    
    deinit {
        Log.debug("DeInit \(#fileID)")
    }
    
    private func bind() {
        viewModel?.output.sectionTitle.bind { [weak self] text in
            guard !text.isEmpty else { return }
            self?.registration.getHeaderText(text: text)
        }
        
        viewModel?.output.items.bind { [weak self] item in
            self?.snapShot(item: item)
        }
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
}

// MARK: - ViewModel 생성 및 주입
extension HomeViewController: InjectViewModel {
    static func creat(with viewModel: HomeViewModelProtocol) -> UIViewController {
        let viewController = HomeViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}

// MARK: - DiffableDataSource 설정
extension HomeViewController {
    private func configureDataSource(in collectionView: UICollectionView) {
        // Cell Provider에 사용할 셀 등록
        let headerRegidtration = registration.creatSectionHeaderRegister()
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
        
        dataSource?.supplementaryViewProvider = { collectionView, _, indexPath in
              collectionView.dequeueConfiguredReusableSupplementary(
                using: headerRegidtration, for: indexPath
              )
        }
        
        self.dataSource = dataSource
    }

    private func snapShot(item: ItemType) {
        var suggestSnapShot = NSDiffableDataSourceSectionSnapshot<AnyHashable>()
        suggestSnapShot.append(item.suggest)

        var citySnapShot = NSDiffableDataSourceSectionSnapshot<AnyHashable>()
        citySnapShot.append(item.city)

        dataSource?.apply(suggestSnapShot, to: .suggest)
        dataSource?.apply(citySnapShot, to: .city)
    }
}
