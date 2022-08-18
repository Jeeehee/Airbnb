//
//  SuggestCell.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/08/11.
//

import UIKit
import SnapKit

final class SuggestCell: UICollectionViewCell {
    static var identifier: String {
        return "\(self)"
    }
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .init(name: NotoSans.regular.name, size: 17)
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
        contentView.addSubview(stackView)
        
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(descriptionLabel)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-50)
        }
    }
}

// MARK: - 속성 변경
extension SuggestCell {
    func configureSuggestCell(model: Suggest?) {
        imageView.image = model?.image
        descriptionLabel.text = model?.description
    }
}
