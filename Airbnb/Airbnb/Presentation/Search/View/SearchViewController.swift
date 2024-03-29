import MapKit
import SnapKit
import UIKit

protocol InjectSearchViewModel {
    static func creat(with viewModel: SearchViewModel) -> UIViewController
}

class SearchViewController: UIViewController {
    private var viewModel: SearchViewModel?
    private let diffableDataSourceManager = DiffableDataSourceManager()
    private let titleView = CloseButtonWithTitleView(title: "여행지를 알려주세요")
    private let searchView = SearchBarView()
    private let underLine = UIView()
    
    private lazy var collectionView: UICollectionView = {
        let layout = LayoutFactory.creatCityCellLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        diffableDataSourceManager.configureSerchViewDataSource(in: collectionView)
        
        attribute()
        layout()
        bind()
    }
    
    private func attribute() {
        guard viewModel != nil else { return }
        view.backgroundColor = .white
        underLine.backgroundColor = .line
        titleView.delegate = self
        searchView.searchViewSearchBardelegate = self
        collectionView.delegate = self
    }
    
    private func layout() {
        view.addSubview(titleView)
        view.addSubview(searchView)
        view.addSubview(underLine)
        view.addSubview(collectionView)
        
        titleView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        
        searchView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
        
        underLine.snp.makeConstraints {
            $0.top.equalTo(searchView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(1)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(underLine.snp.bottom).offset(30)
            $0.leading.trailing.equalTo(underLine)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func bind() {
        viewModel?.output.sectionTitle.bind { [weak self] text in
                guard !text.isEmpty else { return }
                self?.diffableDataSourceManager.getSectionTitle(text: text)
        }
        
        viewModel?.output.items.bind { [weak self] city in
            guard !city.isEmpty else { return }
            self?.diffableDataSourceManager.snapShotInSearchView(item: city)
        }
    }
}

// MARK: - ViewModel 생성 및 주입
extension SearchViewController: InjectSearchViewModel {
    static func creat(with viewModel: SearchViewModel) -> UIViewController {
        let viewController = SearchViewController()
        viewController.viewModel = viewModel
        return viewController
    }
}

// MARK: - Delegate
extension SearchViewController: ColseButtonDelegate {
    func didTabCloseButton(didTab: Bool) {
        if didTab {
            let nextViewController = HomeCoordinator.makeHomeViewController()
            self.navigationController?.pushViewController(nextViewController, animated: false)
        }
    }
}

extension SearchViewController: SearchViewSearchBarDelegate {
    func didGetTheData(didGet: Bool, data: [NSObject]?) {
        switch didGet {
        case true:
            guard let data = data else { return }
            self.diffableDataSourceManager.state = true
            self.diffableDataSourceManager.snapShotAutoCompleteInSearchView(item: data)
        case false:
            self.diffableDataSourceManager.state = false
            // 하단 로직 변경
            viewModel?.output.items.bind { [weak self] city in
                guard !city.isEmpty else { return }
                self?.diffableDataSourceManager.snapShotInSearchView(item: city)
            }
        }
    }
}

extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nextViewController = CalendarViewController()
        navigationController?.pushViewController(nextViewController, animated: true)
    }
}
