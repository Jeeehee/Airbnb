//
//  ViewModelProtocol.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/08/02.
//

import Foundation

protocol HomeViewModelInput {}

protocol HomeViewModelOutput {
    // 옵저버블로 어떤 값을 보낼건지
    var isError: Observable<Bool> { get }
    var errorMessage: Observable<String?> { get }
    var sectionTitle: Observable<[String]> { get }
    var items: Observable<ItemType> { get }
}

protocol HomeViewModelProtocol: HomeViewModelInput, HomeViewModelOutput {
    var input: HomeViewModelInput { get }
    var output: HomeViewModelOutput { get }
}
