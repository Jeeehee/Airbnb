//
//  MapViewController.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/08/19.
//

import GoogleMaps
import GooglePlaces
import SnapKit
import UIKit

class MapViewController: UIViewController {
    private let searchView = SearchBarView()
    private let tableViewDataSource = MapTableViewDataSource()
    private let locationManager = CLLocationManager()

    private lazy var currentLatitude: CLLocationDegrees = {
        guard let latitude = locationManager.location?.coordinate.latitude else {
            return 37.576026
        }
        return latitude
    }()
    
    private lazy var currentlongitude: CLLocationDegrees = {
        guard let longitude = locationManager.location?.coordinate.longitude else {
            return 126.9768428
        }
        return longitude
    }()
    
    private lazy var camera = GMSCameraPosition.camera(
        withLatitude: currentLatitude,
        longitude: currentlongitude,
        zoom: 12)
    
    private lazy var mapView = GMSMapView.map(
        withFrame: CGRect.zero,
        camera: camera)
    
    private let marker = GMSMarker()
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attribute()
        layout()
    }
    
    private func attribute() {
        view.backgroundColor = .white
        locationManager.delegate = self
        
        configureLocationManager()
    }
    
    private func layout() {
        view.addSubview(mapView)
        view.addSubview(searchView)
        view.addSubview(tableViewBackgroundView)

        tableViewBackgroundView.addSubview(tableView)
        tableViewBackgroundView.addSubview(deleteButton)
        tableViewBackgroundView.addSubview(searchButton)
        
        mapView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        searchView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
        
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
            $0.trailing.bottom.equalTo(view.safeAreaLayoutGuide).offset(-30)
            $0.height.equalTo(45)
        }
    }

    private func configureLocationManager() {
        // 정확도 - 제일 높은 등급
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 위치 데이터 승인 요구
        locationManager.requestWhenInUseAuthorization()
        // 위치 업데이트 시작
        locationManager.startUpdatingLocation()
        
    }
}

extension MapViewController: CLLocationManagerDelegate {}
