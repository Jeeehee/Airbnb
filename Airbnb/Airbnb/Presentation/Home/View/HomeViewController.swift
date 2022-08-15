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
    
    private let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: Text.searchBarPlaceholder.text, attributes: [NSAttributedString.Key.foregroundColor: UIColor.textBlack ?? UIColor.black])
        searchBar.searchTextField.font = .init(name: NotoSans.regular.name, size: 15)
        searchBar.searchTextField.layer.masksToBounds = true
        searchBar.searchTextField.layer.cornerRadius = 20
        searchBar.searchTextField.leftView?.tintColor = .black
        searchBar.setPositionAdjustment(UIOffset(horizontal: 10, vertical: 0), for: .search)
        searchBar.backgroundColor = .white
        
//        searchBar.searchTextField.layer.shadowColor = UIColor.black.cgColor
//        searchBar.searchTextField.layer.shadowOpacity = 0.25
//        searchBar.searchTextField.layer.shadowOffset = CGSize(width: 2, height: 2)
//        searchBar.searchTextField.layer.shadowRadius = 5
        return searchBar
    }()
    
    private let underLine = UIView()
    
    private let collectionView: UICollectionView = {
        let layout = LayoutFactory.creatLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(SuggestCell.self, forCellWithReuseIdentifier: SuggestCell.identifier)
        collectionView.register(CityCell.self, forCellWithReuseIdentifier: CityCell.identifier)
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
        navigationItem.titleView = searchBar
        
        underLine.backgroundColor = .line
    }
    
    private func layout() {
        view.addSubview(label)
        view.addSubview(underLine)
        view.addSubview(collectionView)
        view.addSubview(mapButton)
        
        label.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
        
        underLine.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
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
}

// 임시 View
class SearchBarContainerView: UIView {
    let searchBar: UISearchBar
    init(customSearchBar: UISearchBar) {
        searchBar = customSearchBar
        super.init(frame: CGRect.zero)
        addSubview(searchBar)
    }

    override convenience init(frame: CGRect) {
        self.init(customSearchBar: UISearchBar())
        self.frame = frame
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        searchBar.frame = bounds
        backgroundColor = .blue
    }
}
