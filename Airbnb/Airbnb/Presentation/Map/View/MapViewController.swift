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
        
        bind()
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
    
    private func bind() {
        viewModel.coordinator
            .bind { (latitude, longitude) in
                self.setAnnotation("광화문", CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude)))
        }
    }
    
    private func layout() {
        view.addSubview(mapView)
        view.addSubview(searchView)
        view.addSubview(mapTableView)

        mapView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(mapTableView.snp.top).offset(30)
        }
        
        searchView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.height.equalTo(50)
        }
        
        mapTableView.snp.makeConstraints {
            $0.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide)
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
    
    private func setAnnotation(_ title: String, _ coordinator: CLLocationCoordinate2D) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = coordinator
        annotation.title = title
        mapView.addAnnotation(annotation)
    }

}

extension MapViewController: MKMapViewDelegate, CLLocationManagerDelegate {
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        let region = MKCoordinateRegion(center: mapView.userLocation.coordinate,
                                        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        mapView.setRegion(region, animated: true)
    }
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
