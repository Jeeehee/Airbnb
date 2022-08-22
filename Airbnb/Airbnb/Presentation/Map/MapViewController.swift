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
        // 사용자 위치 보기 설정
        mapView.showsUserLocation = true
        // 줌 가능 여부
        mapView.isZoomEnabled = true
        // 스크롤 가능 여부
        mapView.isScrollEnabled = true
        // 회전 가능 여부
        mapView.isRotateEnabled = true
        // 각도 가능 여부
        mapView.isPitchEnabled = true
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

extension MapViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    
}
