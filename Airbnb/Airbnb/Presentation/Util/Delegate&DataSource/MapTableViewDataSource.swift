import UIKit

final class MapTableViewDataSource: NSObject, UITableViewDataSource {
    private let titles = ["위치", "날짜", "여행자"]
    private let descriptions = ["양재역", "2023-01-01", "성인 1"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { 3 }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MapTableViewCell.identifier, for: indexPath) as? MapTableViewCell else { return UITableViewCell() }
        
        cell.configureTitleInMapTableViewCell(title: titles[indexPath.row])
        cell.configureDescriptionInMapTableViewCell(description: descriptions[indexPath.row])
        return cell
    }
}
