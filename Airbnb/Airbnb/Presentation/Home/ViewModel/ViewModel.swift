//
//  ViewModel.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/08/01.
//

import Foundation
import UIKit

struct CellData {
    static let suggestData = [Suggest(id: 1, image: UIImage(named: "image1")!, description: "시원한 바닷가에서 일출보기"),
                                      Suggest(id: 2, image: UIImage(named: "image2")!, description: "고요한 호숫가에서 카약타기 "),
                                      Suggest(id: 3, image: UIImage(named: "image3")!, description: "쏟아질것 같은 별 명소"),
                                      Suggest(id: 4, image: UIImage(named: "image4")!, description: "자연의 신비함을 만끽할 수 있는"),
                                      Suggest(id: 5, image: UIImage(named: "image5")!, description: "연인과 함께하는")
    ]

    static let cityData = [City(id: 1, image: UIImage(named: "Seoul")!, city: "서울", distance: "차로 30분 거리"),
                              City(id: 2, image: UIImage(named: "Gwangju")!, city: "광주", distance: "차로 4시간 거리"),
                              City(id: 3, image: UIImage(named: "Uijeongbu")!, city: "의정부", distance: "차로 30분 거리"),
                              City(id: 4, image: UIImage(named: "Suwon")!, city: "수원", distance: "차로 45분 거리"),
                              City(id: 4, image: UIImage(named: "Daegu")!, city: "대구", distance: "차로 3.5시간 거리"),
                              City(id: 4, image: UIImage(named: "Ulsan")!, city: "울산", distance: "차로 4.5시간 거리"),
                              City(id: 4, image: UIImage(named: "Daejeon")!, city: "대전", distance: "차로 2시간 거리"),
                              City(id: 4, image: UIImage(named: "image1")!, city: "부천", distance: "차로 30분 거리")
    ]
}

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
