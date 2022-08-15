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
        imageView.layer.cornerRadius = 10
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
        label.font = .init(name: NotoSans.medium.name, size: 18)
        return label
    }()
    
    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.font = .init(name: NotoSans.light.name, size: 17)
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
        addSubview(imageView)
        addSubview(stackView)
        
        stackView.addArrangedSubview(cityLabel)
        stackView.addArrangedSubview(distanceLabel)
        
        imageView.snp.makeConstraints {
            $0.top.bottom.leading.equalToSuperview()
            $0.width.equalTo(self.snp.height)
        }
        
        stackView.snp.makeConstraints {
            $0.centerY.equalTo(imageView)
            $0.leading.equalTo(imageView.snp.trailing).offset(10)
            $0.trailing.equalToSuperview()
        }
    }
}

// MARK: - 속성 변경
extension CityCell {
    func configureSuggestCell(model: City?) {
        imageView.image = UIImage(named: "\(String(describing: model?.image))")
        cityLabel.text = model?.city
        distanceLabel.text = model?.distance
    }
}
