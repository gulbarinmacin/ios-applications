//
//  CitiesTableViewController.swift
//  hw2-gmacin18
//
//  Created by Lab on 27.11.2022.
//

import UIKit

class CitiesTableViewController: UIViewController {

    @IBOutlet weak var cityListTableView: UITableView!
    
    var cityDataSource = CityDataSource()
    
    override func viewDidLoad() {
        self.title = "Cities List"
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        cityDataSource.delegate = self
        cityDataSource.getListOfCities()
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         if  let cell = sender as? CityTableViewCell,
             let indexPath = self.cityListTableView.indexPath(for: cell),
             let city = cityDataSource.getCity(for: indexPath.row),
             let regionTable = segue.destination as? RegionsTableViewController {
                 regionTable.cityIdentifier = city.Id
             }
     }
    
}

extension CitiesTableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityDataSource.getNumberOfCities()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell") as? CityTableViewCell else {
            return UITableViewCell()
        }
        if let city = cityDataSource.getCity(for: indexPath.row) {
            cell.cityLabel.text = city.Name
        } else {
            cell.cityLabel.text = ""
        }
        return cell
    }
}

extension CitiesTableViewController: DataSourceDelegate {
    func cityListLoaded() {
        cityListTableView.reloadData()
    }
}
