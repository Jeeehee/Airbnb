//
//  MapViewModel.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/12/05.
//

import Foundation
protocol MapViewModelInput {
    var showSearchView: Observable<Bool> { get }
}

protocol MapViewModelOutput {
}

protocol MapViewModelProtocol: MapViewModelInput, MapViewModelOutput {
    var input: MapViewModelInput { get }
    var output: MapViewModelOutput { get }
}

struct MapViewModel: MapViewModelProtocol {
    var input: MapViewModelInput { self }
    var output: MapViewModelOutput { self }
    
    var showSearchView = Observable(false)
    
}
