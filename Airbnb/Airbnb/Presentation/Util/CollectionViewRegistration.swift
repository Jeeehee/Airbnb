//
//  CollectionViewRegistration.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/08/16.
//

import UIKit

typealias DataSource = UICollectionViewDiffableDataSource<SectionType, AnyHashable>

struct CollectionViewRegistration {
    // <어떤 셀에, 어떤데이터를> 넣을거니
    func createSuggestCellRegister() -> UICollectionView.CellRegistration<SuggestCell, Suggest> {
        UICollectionView.CellRegistration.init { cell, _, item in
            cell.configureSuggestCell(model: item)
        }
    }
    
    func createCityCellRegister() -> UICollectionView.CellRegistration<CityCell, City> {
        UICollectionView.CellRegistration.init { cell, _, item in
            cell.configureCityCell(model: item)
        }
    }
}
