//
//  Delegate.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/08/23.
//

import Foundation

protocol SearchBarDelegate: AnyObject {
    func didBeginEditing(isStartEditing: Bool)
}

protocol ColseButtonDelegate: AnyObject {
    func didTabCloseButton(didTab: Bool)
}

protocol SearchViewSearchBarDelegate: AnyObject {
    func didGetTheData(didGet: Bool, data: [NSObject]?)
}
