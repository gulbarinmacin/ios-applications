//
//  RegionsTableViewController.swift
//  hw2-gmacin18
//
//  Created by Lab on 27.11.2022.
//

import UIKit

class RegionsTableViewController: UIViewController {

    @IBOutlet weak var regionListTableView: UITableView!
    
    var cityIdentifier: Int?
    var regionDataSource = RegionDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Regions List"
        regionDataSource.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        if let cityId = cityIdentifier {
            regionDataSource.getListOfRegions(cityId: cityId)
        }
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if  let cell = sender as? RegionTableViewCell,
            let indexPath = self.regionListTableView.indexPath(for: cell),
            let region = regionDataSource.getRegion(for: indexPath.row),
            let pharmacyTable = segue.destination as? PharmacyTableViewController{
            pharmacyTable.regionIdentifier = region.Id
                }
    }
    
    func getRealIndex(indexPath: IndexPath) -> Int {
        if (regionDataSource.getNumberOfRegions() == 0) {
            return 0;
        }
        let index = indexPath.row.quotientAndRemainder(dividingBy: regionDataSource.getNumberOfRegions()).remainder
        return index
    }
}

extension RegionsTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regionDataSource.getNumberOfRegions()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RegionCell") as? RegionTableViewCell else {
            return UITableViewCell()
        }
        if let region = regionDataSource.getRegion(for: indexPath.row) {
            cell.regionLabel.text = region.Name
        } else {
            cell.regionLabel.text = ""
        }
        return cell
    }
}
extension RegionsTableViewController: DataSourceDelegate {
    func regionListLoaded(region: [Region]) {
        regionListTableView.reloadData()
    }
    
}
