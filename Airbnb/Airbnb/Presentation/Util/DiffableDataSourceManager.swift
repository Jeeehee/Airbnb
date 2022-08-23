//
//  DiffableDataSourceManager.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/08/23.
//

import UIKit

typealias DataSource = UICollectionViewDiffableDataSource<SectionType, AnyHashable>

final class DiffableDataSourceManager {
    var dataSource: DataSource?
    private let registration = CollectionViewRegistration()
    
    func configureDataSource(in collectionView: UICollectionView) {
        // Cell Provider에 사용할 셀 등록
        let headerRegistration = registration.creatSectionHeaderRegister()
        let suggestCellRegistration = registration.createSuggestCellRegister()
        let cityCellRegistration = registration.createCityCellRegister()

        let dataSource: DataSource? = .init(collectionView: collectionView) { collectionView, indexPath, item in
            // indexPath의 Section을 이용해서 우리가 정의한 SectionType(Enum)을 만든다.
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

    func snapShot(item: ItemType) {
        var suggestSnapShot = NSDiffableDataSourceSectionSnapshot<AnyHashable>()
        suggestSnapShot.append(item.suggest)

        var citySnapShot = NSDiffableDataSourceSectionSnapshot<AnyHashable>()
        citySnapShot.append(item.city)

        dataSource?.apply(suggestSnapShot, to: .suggest)
        dataSource?.apply(citySnapShot, to: .city)
    }
    
    func getSectionTitle(text: [String]) {
        self.registration.getSectionTitle(text: text)
    }
}
