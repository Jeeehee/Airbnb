//
//  Delegate.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/08/23.
//

import Foundation

protocol HomeViewSearchBarDelegate {
    func didBeginEditing(isStartEditing: Bool)
}

protocol ColseButtonDelegate {
    func didTabCloseButton(didTab: Bool)
}

protocol SearchViewSearchBarDelegate {
    func didGetTheData(didGet: Bool, data: [NSObject]?)
}
