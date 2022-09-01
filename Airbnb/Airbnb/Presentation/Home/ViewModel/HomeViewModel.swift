//
//  ViewModel.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/08/01.
//

import Foundation

struct HomeViewModel: HomeViewModelProtocol {
    var input: HomeViewModelInput { self }
    var output: HomeViewModelOutput { self }
    
    let isError: Observable<Bool> = Observable(false)
    let errorMessage: Observable<String?> = Observable("NoError")
    let sectionTitle: Observable<[String]> = Observable([
        "어디에서나, 여행은\n살아보는거야!", "가까운 여행지 둘러보기"
    ])
    let items = Observable(ItemType(suggest: CellData.suggestData, city: CellData.cityData))
    
    // Usecase
}
