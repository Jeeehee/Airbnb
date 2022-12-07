import UIKit

final class SearchCoordinator {
    static func makeSearchViewController() -> UIViewController {
        let viewModel = SearchViewModel()
        return SearchViewController.creat(with: viewModel)
    }
}
