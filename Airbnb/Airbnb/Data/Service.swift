//
//  Service.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/09/05.
//

import Foundation

final class Service {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
}
