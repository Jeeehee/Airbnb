//
//  DTO.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/09/05.
//

import Foundation

struct LocationDTO: Decodable {
    let latitude: Int
    let longitude: Int
    
    private enum CodingKeys: String, CodingKey {
        case latitude = "REFINE_WGS84_LOGT"
        case longitude = "REFINE_WGS84_LAT"
    }
}
