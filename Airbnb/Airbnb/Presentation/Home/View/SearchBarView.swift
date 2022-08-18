//
//  SearchBarView.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/08/17.
//

import UIKit
import SnapKit

class SearchBarView: UIView {
    private lazy var searchBar: UISearchBar = {
        let image = setSearchBarBackground(color: .white, size: CGSize(width: 10, height: 100))
        let searchBar = UISearchBar()
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: Text.searchBarPlaceholder.text, attributes: [NSAttributedString.Key.foregroundColor: UIColor.textBlack ?? UIColor.black])
        searchBar.setSearchFieldBackgroundImage(image, for: .normal)
        searchBar.searchTextField.font = .init(name: NotoSans.regular.name, size: 15)
        searchBar.searchTextField.leftView?.tintColor = .black
        searchBar.layer.masksToBounds = true
        searchBar.layer.cornerRadius = 25
        return searchBar
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        attribute()
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Init with coder is unavailable")
    }
    
    private func attribute() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.18
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 5
        layer.shouldRasterize = true // 그림자를 캐시에 저장 -> 재활용
    }
    
    private func layout() {
        addSubview(searchBar)
        
        searchBar.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setSearchBarBackground(color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
