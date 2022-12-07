import UIKit
import MapKit

typealias DataSource = UICollectionViewDiffableDataSource<SectionType, AnyHashable>

final class DiffableDataSourceManager {
    private let registration = CollectionViewRegistration()
    var dataSource: DataSource?
    var state = false
    
    func configureDataSource(in collectionView: UICollectionView) {
        guard let headerFont = UIFont.init(name: NotoSans.medium.name, size: 22) else {
            UIFont.systemFont(ofSize: 22, weight: .medium); return
        }
        let headerRegistration = registration.creatSectionHeaderRegister(font: headerFont)
        let suggestCellRegistration = registration.createSuggestCellRegister()
        let cityCellRegistration = registration.createCityCellRegister()

        let dataSource: DataSource? = .init(collectionView: collectionView) { collectionView, indexPath, item in
            guard let section = SectionType(rawValue: indexPath.section) else { return nil }

            switch section {
            case .suggest:
                guard let item = item as? Suggest else { return nil }
                return collectionView.dequeueConfiguredReusableCell(
                    using: suggestCellRegistration,
                    for: indexPath,
                    item: item)

            case .city:
                guard let item = item as? City else { return nil }
                return collectionView.dequeueConfiguredReusableCell(
                    using: cityCellRegistration,
                    for: indexPath,
                    item: item)
            }
        }

        dataSource?.supplementaryViewProvider = { collectionView, _, indexPath in
              collectionView.dequeueConfiguredReusableSupplementary(
                using: headerRegistration, for: indexPath)
        }
        
        self.dataSource = dataSource
    }
    
    func configureSerchViewDataSource(in collectionView: UICollectionView) {
        guard let headerFont = UIFont.init(name: NotoSans.medium.name, size: 17) else {
            UIFont.systemFont(ofSize: 17, weight: .medium); return
        }
        let headerRegistration = registration.creatSectionHeaderRegister(font: headerFont)
        let cityCellRegistration = registration.createCityCellRegister()
        let autoCompleteCellRegistration = registration.createAutoCompleteCellRegister()
        
        let dataSource: DataSource? = .init(collectionView: collectionView) { collectionView, indexPath, item in
            
            switch self.state {
            case true:
                guard let item = item as? MKLocalSearchCompletion else { return nil }
                return collectionView.dequeueConfiguredReusableCell(
                    using: autoCompleteCellRegistration,
                    for: indexPath,
                    item: item)
            case false:
                guard let item = item as? City else { return nil }
                return collectionView.dequeueConfiguredReusableCell(
                    using: cityCellRegistration,
                    for: indexPath,
                    item: item)
            }
        }
        
        dataSource?.supplementaryViewProvider = { collectionView, _, indexPath in
              collectionView.dequeueConfiguredReusableSupplementary(
                using: headerRegistration, for: indexPath)
        }
        
        self.dataSource = dataSource
    }

    func snapShot(item: ItemType) {
        var suggestSnapShot = NSDiffableDataSourceSectionSnapshot<AnyHashable>()
        guard let suggest = item.suggest else { return }
        suggestSnapShot.append(suggest)

        var citySnapShot = NSDiffableDataSourceSectionSnapshot<AnyHashable>()
        citySnapShot.append(item.city)

        dataSource?.apply(suggestSnapShot, to: .suggest)
        dataSource?.apply(citySnapShot, to: .city)
    }
    
    func snapShotAutoCompleteInSearchView(item: [NSObject]) {
        var autoCompleteSnapShot = NSDiffableDataSourceSectionSnapshot<AnyHashable>()
        autoCompleteSnapShot.append(item)

        dataSource?.apply(autoCompleteSnapShot, to: .city)
    }
    
    func snapShotInSearchView(item: [City]) {
        var citySnapShot = NSDiffableDataSourceSectionSnapshot<AnyHashable>()
        citySnapShot.append(item)

        dataSource?.apply(citySnapShot, to: .city)
    }
    
    func getSectionTitle(text: [String]) {
        self.registration.getSectionTitle(text: text)
    }
}
