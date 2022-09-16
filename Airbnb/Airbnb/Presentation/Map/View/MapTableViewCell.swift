//
//  MapTableViewCell.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/09/05.
//

import UIKit
import SnapKit

class MapTableViewCell: UITableViewCell {
    static var identifier: String {
        return "\(self)"
    }
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .init(name: NotoSans.medium.name, size: 16)
        label.textColor = .black
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .init(name: NotoSans.light.name, size: 14)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("Init with coder is unavailable")
    }
    
    private func layout() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.leading.equalToSuperview().offset(30)
            $0.bottom.equalToSuperview().offset(-15)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(15)
            $0.trailing.equalToSuperview().offset(-30)
        }
    }
}

// MARK: - 속성 변경
extension MapTableViewCell {
    func configureTitleInMapTableViewCell(title: String) {
        titleLabel.text = title
    }
    
    func configureDescriptionInMapTableViewCell(description: String) {
        descriptionLabel.text = description
    }
}
