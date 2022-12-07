import Foundation

protocol MapViewModelInput {
}

protocol MapViewModelOutput {
    var coordinator: Observable<(Double, Double)> { get }
}

protocol MapViewModelProtocol: MapViewModelInput, MapViewModelOutput {
    var input: MapViewModelInput { get }
    var output: MapViewModelOutput { get }
}

struct MapViewModel: MapViewModelProtocol {
    var input: MapViewModelInput { self }
    var output: MapViewModelOutput { self }
    
    var coordinator: Observable<(Double, Double)> = Observable((37.51818789942772, 126.88541765534976))
}
