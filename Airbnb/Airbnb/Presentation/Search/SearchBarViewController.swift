//
//  SearchBarViewController.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/08/22.
//

import SnapKit
import UIKit

class SearchBarViewController: UIViewController {
    private let titleView = CloseButtonWithTitleView(title: "여행지를 알려주세요")
    private let searchView = SearchBarView()
    private let underLine = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
    
    private func attribute() {
        view.backgroundColor = .white
        underLine.backgroundColor = .line
    }
    
    private func layout() {
        view.addSubview(titleView)
        view.addSubview(searchView)
        view.addSubview(underLine)
        
        titleView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(40)
        }
        
        searchView.snp.makeConstraints {
            $0.top.equalTo(titleView.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
        
        underLine.snp.makeConstraints {
            $0.top.equalTo(searchView.snp.bottom).offset(30)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(1)
        }
    }
}
