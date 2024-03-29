import UIKit
import SnapKit

final class CityCell: UICollectionViewCell {
    static var identifier: String {
        return "\(self)"
    }
    
    private let imageView = UIImageView()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()
    
    private let cityLabel: UILabel = {
        let label = UILabel()
        label.font = .init(name: NotoSans.medium.name, size: 16)
        return label
    }()
    
    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.font = .init(name: NotoSans.regular.name, size: 15)
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
    
    private func configureAutoCompleteImageView() {
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.backgroundColor = .grayBackground
        imageView.image = .init(named: "symbol")
    }
}

// MARK: - 속성 변경
extension CityCell {
    func configureCityCell(model: City?) {
        imageView.image = model?.image
        cityLabel.text = model?.city
        distanceLabel.text = model?.distance
    }
    
    func configureAutoCompleteCell(title: String, address: String) {
        configureAutoCompleteImageView()
        cityLabel.text = title
        distanceLabel.text = address
    }
}
