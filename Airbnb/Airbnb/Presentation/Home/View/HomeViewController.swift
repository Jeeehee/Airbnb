import UIKit
import SnapKit

protocol InjectHomeViewModel {
    static func creat(with viewModel: HomeViewModel) -> UIViewController
}

class HomeViewController: UIViewController {
    private var viewModel: HomeViewModel?
    private let diffableDataSourceManager = DiffableDataSourceManager()
    private let searchView = SearchBarView()
    private let underLine = UIView()
    
    private var collectionView: UICollectionView = {
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

//        let repo = Repository()
//        repo.getAddress { data in
//            print("ddd")
//            switch data {
//
//            case let .success(address):
//                print(address)
//            case let .failure(error):
//                print(error)
//            }
//        }
        
        diffableDataSourceManager.configureDataSource(in: collectionView)
        addActionOfButton()
        
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
            self?.diffableDataSourceManager.getSectionTitle(text: text)
        }
        
        viewModel?.output.items.bind { [weak self] item in
            self?.diffableDataSourceManager.snapShot(item: item)
        }
    }
    
    private func attribute() {
        guard viewModel != nil else { return }
        
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

    
    private func addActionOfButton() {
        mapButton.addAction(.init(handler: { _ in
            let nextVieController = MapViewController()
            self.navigationController?.pushViewController(nextVieController, animated: true)
        }), for: .touchUpInside)
    }
}

// MARK: - ViewModel 생성 및 주입
extension HomeViewController: InjectHomeViewModel {
    static func creat(with viewModel: HomeViewModel) -> UIViewController {
        let viewController = HomeViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}

// MARK: - Delegate
extension HomeViewController: SearchBarDelegate {
    func didBeginEditing(isStartEditing: Bool) {
        if isStartEditing {
            let nextViewController = SearchCoordinator.makeSearchViewController()
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
}
