//
//  SearchViewDelegate.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/08/23.
//

import Foundation

protocol SearchViewDelegate {
    func didTabCloseButton(didTab: Bool)
}

protocol SearchViewSearchBarDelegate {
    func didGetTheData(didGet: Bool, data: [NSObject]?)
}
