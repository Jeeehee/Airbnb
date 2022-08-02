//
//  ViewModelProtocol.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/08/02.
//

import Foundation

protocol HomeViewModelInput {}

protocol HomeViewModelOutput {}

protocol HomeViewModelProtocol: HomeViewModelInput, HomeViewModelOutput {
    var input: HomeViewModelInput { get }
    var output: HomeViewModelOutput { get }
}
