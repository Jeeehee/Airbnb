//
//  CollectionViewRegistration.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/08/16.
//

import UIKit

final class CollectionViewRegistration {
    // <어떤 셀에, 어떤데이터를> 넣을거니
    private var headerText = [String]()
    
    func creatSectionHeaderRegister() -> UICollectionView.SupplementaryRegistration<HeaderView> {
        UICollectionView.SupplementaryRegistration.init(elementKind: "header") { supplementaryView, _, indexPath in
            supplementaryView.configureHeaderView(title: self.headerText[indexPath.section])
        }
    }
    
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
    
    func getSectionTitle(text: [String]) {
        headerText = text
    }
}
