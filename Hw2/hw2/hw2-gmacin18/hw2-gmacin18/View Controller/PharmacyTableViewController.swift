//
//  PharmacyTableViewController.swift
//  hw2-gmacin18
//
//  Created by Lab on 27.11.2022.
//

import UIKit

class PharmacyTableViewController: UIViewController {

    @IBOutlet weak var pharmacyListTableView: UITableView!
    
    var regionIdentifier: String?
    var pharmacyDataSource = PharmacyDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Pharmacies List"
        pharmacyDataSource.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let regionId = regionIdentifier {
            pharmacyDataSource.getListOfPharmacy(regionId: regionId)
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if  let cell = sender as? PharmacyTableViewCell,
            let indexPath = self.pharmacyListTableView.indexPath(for: cell),
            let pharmacy = pharmacyDataSource.getPharmacy(for: indexPath.row),
            let detailView = segue.destination as? DetailViewController {
            detailView.pharmacyIdentifier = pharmacy.Id
        }
    }

}
extension PharmacyTableViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pharmacyDataSource.getNumberOfPharmacies()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PharmacyCell") as? PharmacyTableViewCell else {
            return UITableViewCell()
        }
        if let pharmacy = pharmacyDataSource.getPharmacy(for: indexPath.row) {
            cell.pharmacyLabel.text = pharmacy.Name
        
        } else {
            cell.pharmacyLabel.text = ""
        }
        return cell
    }
}

extension PharmacyTableViewController: DataSourceDelegate {
    func pharmacyListLoaded(pharmacy: [Pharmacy]) {
        pharmacyListTableView.reloadData()
    }

}
