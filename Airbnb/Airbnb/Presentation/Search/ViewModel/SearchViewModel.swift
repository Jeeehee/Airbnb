//
//  SearchViewModel.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/08/23.
//

import Foundation

struct SearchViewModel: SearchViewModelProtocol {
    var input: SearchViewModelInput { self }
    var output: SearchViewModelOutput { self }
    
    let isError: Observable<Bool> = Observable(false)
    let errorMessage: Observable<String?> = Observable("NoError")
    let sectionTitle: Observable<[String]> = Observable(["근처 인기 여행지"])
    let items: Observable<[City]> = Observable(CellData.cityData)
}
