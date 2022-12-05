//
//  MapViewController.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/08/19.
//

import MapKit
import SnapKit
import UIKit

class MapViewController: UIViewController {
    private let locationManager = CLLocationManager()
    private let mapView = MKMapView()
    private let searchView = SearchBarView()
    private let tableViewDataSource = MapTableViewDataSource()
    private let viewModel = MapViewModel()
    
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
        
        mapView.delegate = self
        locationManager.delegate = self
        searchView.searchBardelegate = self
        
        configureMapView()
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
    
    private func bind() {
    }
    
    private func configureMapView() {
        mapView.showsUserLocation = true
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.isRotateEnabled = true
        mapView.isPitchEnabled = true
    }
    
    private func configureLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension MapViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    
}

// MARK: - Delegate
extension MapViewController: SearchBarDelegate {
    func didBeginEditing(isStartEditing: Bool) {
        if isStartEditing {
            let nextViewController = SearchCoordinator.makeSearchViewController()
            self.navigationController?.pushViewController(nextViewController, animated: true)
        }
    }
}
