//
//  MapTableView.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/12/06.
//

import SnapKit
import UIKit

final class MapTableView: UIView {
    private let tableViewDataSource = MapTableViewDataSource()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.register(MapTableViewCell.self, forCellReuseIdentifier: MapTableViewCell.identifier)
        tableView.isScrollEnabled = false
        tableView.dataSource = tableViewDataSource
        return tableView
    }()
    
    private let tableViewBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    private let deleteButton: UIButton = {
        let button = UIButton()
        let attributes: [NSAttributedString.Key: Any] = [
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
        button.setAttributedTitle(NSAttributedString(string: "전체 삭제", attributes: attributes), for: .normal)
        button.setTitleColor(UIColor.gray, for: .normal)
        button.titleLabel?.font = .init(name: NotoSans.regular.name, size: 14)
        return button
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setTitle("검색", for: .normal)
        button.titleLabel?.font = .init(name: NotoSans.bold.name, size: 15)
        button.clipsToBounds = true
        button.layer.cornerRadius = 8
        button.backgroundColor = .primary
        return button
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
        addSubview(tableViewBackgroundView)
        
        tableViewBackgroundView.addSubview(tableView)
        tableViewBackgroundView.addSubview(deleteButton)
        tableViewBackgroundView.addSubview(searchButton)
        
        tableViewBackgroundView.snp.makeConstraints {
            $0.top.equalTo(tableView.snp.top).offset(-10)
            $0.bottom.leading.trailing.equalToSuperview()
        }
        
        tableView.snp.makeConstraints {
            $0.bottom.equalTo(deleteButton.snp.top).offset(-10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(150)
        }
        
        deleteButton.snp.makeConstraints {
            $0.bottom.equalTo(searchButton.snp.top).offset(-10)
            $0.leading.equalToSuperview().offset(30)
        }
        
        searchButton.snp.makeConstraints {
            $0.top.equalTo(deleteButton).offset(40)
            $0.leading.equalToSuperview().offset(30)
            $0.trailing.bottom.equalTo(safeAreaLayoutGuide).offset(-30)
            $0.height.equalTo(45)
        }
    }
}
