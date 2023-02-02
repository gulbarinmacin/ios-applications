//
//  DetailViewController.swift
//  hw2-gmacin18
//
//  Created by Lab on 27.11.2022.
//

import UIKit

class DetailViewController: UIViewController {

    
    
    @IBOutlet weak var Name: UILabel!
    
    
    
    
    @IBOutlet weak var Address: UILabel!
    
    
    @IBOutlet weak var Number: UILabel!
    
    
    var pharmacyIdentifier: String?
    var pharmacyDataSource = PharmacyDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()

        pharmacyDataSource.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        if let pharmacyId = pharmacyIdentifier {
            pharmacyDataSource.getDetail(pharmacyId: pharmacyId)
        }
    }

}
extension DetailViewController: DataSourceDelegate {
    func detailsLoaded(pharmacy: Detail) {
        self.title = pharmacy.Name
        self.Name.text = pharmacy.Name
        self.Address.text = pharmacy.Address
        self.Number.text = pharmacy.Phone
    }
    
}
