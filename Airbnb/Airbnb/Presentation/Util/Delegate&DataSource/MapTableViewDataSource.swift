//
//  MapTableViewDataSource.swift
//  Airbnb
//
//  Created by Jihee hwang on 2022/09/06.
//

import UIKit

final class MapTableViewDataSource: NSObject, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 3 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MapTableViewCell.identifier, for: indexPath) as? MapTableViewCell else { return UITableViewCell() }
        cell.configureTitleInMapTableViewCell(title: "dddd")
        cell.configureDescriptionInMapTableViewCell(description: "ddddddddddd")
        return cell
    }
}
