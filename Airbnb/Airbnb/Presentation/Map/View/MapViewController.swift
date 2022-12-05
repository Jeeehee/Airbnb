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
    private let searchView = SearchBarView()
    private let mapView = MKMapView()
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
    
    private func attribute() {
        view.backgroundColor = .white
        mapView.delegate = self
        locationManager.delegate = self
        configureMapView()
        configureLocationManager()
    }
    
    private func layout() {
        view.addSubview(mapView)
        view.addSubview(searchView)
        
        mapView.snp.makeConstraints {
            $0.top.bottom.leading.trailing.equalToSuperview()
        }
        
        searchView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
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
