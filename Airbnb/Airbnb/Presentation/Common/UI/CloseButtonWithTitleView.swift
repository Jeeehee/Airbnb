//
//  CloseButtonWithTitleView.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/08/22.
//

import UIKit

final class CloseButtonWithTitleView: UIView {
    private let titleLable: UILabel = {
        let label = UILabel()
        label.font = .init(name: NotoSans.bold.name, size: 18)
        label.textColor = .black
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 20
        button.setImage(UIImage.init(systemName: "xmark"), for: .normal)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.line?.cgColor
        button.backgroundColor = .greyBackground
        button.tintColor = .black
        return button
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        self.titleLable.text = title
        
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Init with coder is unavailable")
    }
    
    private func layout() {
        addSubview(closeButton)
        addSubview(titleLable)
        
        closeButton.snp.makeConstraints {
            $0.top.leading.equalTo(safeAreaLayoutGuide).offset(20)
            $0.width.height.equalTo(40)
        }
        
        titleLable.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(closeButton)
        }
    }
}
