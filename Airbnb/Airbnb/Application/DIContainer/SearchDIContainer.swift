//
//  SearchDIContainer.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/08/24.
//

import UIKit

final class SearchDIContainer {
    static func makeSearchViewController() -> UIViewController {
        let viewModel = SearchViewModel()
        return SearchViewController.creat(with: viewModel)
    }
}
