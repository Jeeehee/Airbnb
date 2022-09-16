//
//  Suggest.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/08/11.
//

import UIKit

struct Suggest: Hashable, Identifiable {
    typealias Identifier = Int

    let id: Identifier
    let image: UIImage
    let description: String
}
