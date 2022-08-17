//
//  SearchBarView.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/08/17.
//

import UIKit
import SnapKit

class SearchBarView: UIView {
    private let backgroundView = UIView()
    
    private lazy var searchBar: UISearchBar = {
        let image = setSearchBarBackground(color: .white, size: CGSize(width: 10, height: 180))
        let searchBar = UISearchBar()
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: Text.searchBarPlaceholder.text, attributes: [NSAttributedString.Key.foregroundColor: UIColor.textBlack ?? UIColor.black])
        searchBar.setSearchFieldBackgroundImage(image, for: .normal)
        searchBar.searchTextField.font = .init(name: NotoSans.regular.name, size: 15)
        searchBar.searchTextField.layer.masksToBounds = true
        searchBar.searchTextField.layer.cornerRadius = 10
        searchBar.searchTextField.leftView?.tintColor = .black
//        searchBar.setPositionAdjustment(UIOffset(horizontal: 10, vertical: 0), for: .search)
        searchBar.backgroundColor = .white
        searchBar.searchBarStyle = .minimal
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
        clipsToBounds = false
        layer.cornerRadius = 25
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 5
    }
    
    private func layout() {
        addSubview(searchBar)
        
        searchBar.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setSearchBarBackground(color: UIColor, size: CGSize) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 0)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        path.fill()
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}
