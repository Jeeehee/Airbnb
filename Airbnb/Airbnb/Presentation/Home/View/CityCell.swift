//
//  CityCell.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/08/11.
//

import UIKit
import SnapKit

final class CityCell: UICollectionViewCell {
    static var identifier: String {
        return "\(self)"
    }
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 7
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.font = .init(name: NotoSans.medium.name, size: 17)
        return label
    }()
    
    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.font = .init(name: NotoSans.light.name, size: 16)
        label.textColor = .lightGray
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
        contentView.addSubview(imageView)
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(cityLabel)
        stackView.addArrangedSubview(distanceLabel)
        
        imageView.snp.makeConstraints {
            $0.top.leading.equalTo(contentView)
            $0.width.height.equalTo(contentView.snp.height)
        }
        
        stackView.snp.makeConstraints {
            $0.centerY.equalTo(imageView)
            $0.leading.equalTo(imageView.snp.trailing).offset(15)
            $0.trailing.equalToSuperview()
        }
    }
}

// MARK: - 속성 변경
extension CityCell {
    func configureCityCell(model: City?) {
        imageView.image = model?.image
        cityLabel.text = model?.city
        distanceLabel.text = model?.distance
    }
}
