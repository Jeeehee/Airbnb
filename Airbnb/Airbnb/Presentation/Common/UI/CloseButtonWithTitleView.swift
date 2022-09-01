//
//  CloseButtonWithTitleView.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/08/22.
//

import UIKit

final class CloseButtonWithTitleView: UIView {
    var delegate: SearchViewDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .init(name: NotoSans.bold.name, size: 18)
        label.textColor = .black
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        let imageConfiguration = UIImage.SymbolConfiguration(pointSize: 13)
        button.setImage(UIImage.init(systemName: "xmark", withConfiguration: imageConfiguration), for: .normal)
        button.clipsToBounds = true
        button.layer.cornerRadius = 17
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.line?.cgColor
        button.tintColor = .gray
        return button
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        self.titleLabel.text = title
  
        layout()
        addActionOfButton()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Init with coder is unavailable")
    }
    
    private func layout() {
        addSubview(closeButton)
        addSubview(titleLabel)
        
        closeButton.snp.makeConstraints {
            $0.top.leading.equalTo(safeAreaLayoutGuide).offset(20)
            $0.width.height.equalTo(32)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.centerY.equalTo(closeButton)
        }
    }
    
    private func addActionOfButton() {
        closeButton.addAction(.init(handler: { _ in
            self.delegate?.didTabCloseButton(didTab: true)
        }), for: .touchUpInside)
    }
}
