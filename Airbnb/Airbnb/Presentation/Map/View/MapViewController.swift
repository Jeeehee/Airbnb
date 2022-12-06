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
    private var locationManager = CLLocationManager()
    private let mapView = MKMapView()
    private let searchView = SearchBarView()
    private let viewModel = MapViewModel()
    private let mapTableView = MapTableView()
    
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
        view.addSubview(mapTableView)

        mapView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(mapTableView.snp.top)
        }
        
        searchView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
        
        mapTableView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalToSuperview()
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
        let region = MKCoordinateRegion(center: mapView.userLocation.coordinate,
                                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
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
