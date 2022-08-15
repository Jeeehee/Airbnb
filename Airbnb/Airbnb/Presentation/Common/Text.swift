//
//  Text.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/08/11.
//

import Foundation

enum Text: String {
    case searchBarPlaceholder
    case mapButtonText
    
    var text: String {
        switch self {
        case .searchBarPlaceholder:
            return "어디로 여행가세요?"
        case .mapButtonText:
            return "지도"
        }
    }
}
