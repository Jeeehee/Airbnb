import MapKit
import UIKit

final class CollectionViewRegistration {
    private var headerText = [String]()
    
    func creatSectionHeaderRegister(font: UIFont) -> UICollectionView.SupplementaryRegistration<HeaderView> {
        UICollectionView.SupplementaryRegistration.init(elementKind: "header") { supplementaryView, _, indexPath in
            supplementaryView.configureHeaderView(title: self.headerText[indexPath.section], font: font)
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
    
    func createAutoCompleteCellRegister() -> UICollectionView.CellRegistration<CityCell, MKLocalSearchCompletion> {
        UICollectionView.CellRegistration.init { cell, _, item in
            cell.configureAutoCompleteCell(title: item.title, address: item.subtitle)
        }
    }
    
    func getSectionTitle(text: [String]) {
        headerText = text
    }
}
