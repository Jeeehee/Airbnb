import UIKit

final class HomeCoordinator {
    static func makeHomeViewController() -> UIViewController {
        let viewModel = HomeViewModel()
        return HomeViewController.creat(with: viewModel)
    }
}
