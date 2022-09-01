//
//  HeaderView.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/08/11.
//

import UIKit
import SnapKit

final class HeaderView: UICollectionReusableView {
    var identifier: String {
        return "\(self)"
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Init with coder is unavailable")
    }
    
    private func layout() {
        addSubview(titleLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.leading.equalToSuperview()
        }
    }
}

// MARK: - 속성 변경
extension HeaderView {
    func configureHeaderView(title: String, font: UIFont) {
        titleLabel.text = title
        titleLabel.font = font
    }
}
