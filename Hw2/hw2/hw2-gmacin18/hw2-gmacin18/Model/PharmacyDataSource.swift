//
//  PharmacyDataSource.swift
//  hw2-gmacin18
//
//  Created by Lab on 27.11.2022.
//

import Foundation
class PharmacyDataSource{
    private let baseURL = "https://koc.api.staging.tarentum.io"
    var delegate: DataSourceDelegate?
    private var pharmacyArray: [Pharmacy] = []
        
    func getListOfPharmacy (regionId: String) {
        let urlSession = URLSession.shared
        if let url = URL(string: "\(baseURL)/region/\(regionId)/pharmacy") {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let dataTask = urlSession.dataTask(with: urlRequest) { data, response, error in
                let decoder = JSONDecoder()
                if let data = data {
                    let pharmacies = try! decoder.decode([Pharmacy].self, from: data)
                    self.pharmacyArray = pharmacies
                    DispatchQueue.main.async {
                        self.delegate?.pharmacyListLoaded(pharmacy: pharmacies)
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    func getNumberOfPharmacies() -> Int {
        return pharmacyArray.count
    }
    
    func getPharmacy(index: Int) -> Pharmacy {
        return pharmacyArray[index]
    }
    
    func getPharmacy(for index: Int) -> Pharmacy? {
        guard index < pharmacyArray.count else {
            return nil
        }
        return  pharmacyArray[index]
    }
    
    func getDetail(pharmacyId: String) {
        let urlSession = URLSession.shared
        if let url = URL(string: "\(baseURL)/pharmacy/\(pharmacyId)") {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let dataTask = urlSession.dataTask(with: urlRequest) { data, response, error in
                let decoder = JSONDecoder()
                if let data = data {
                    let details = try! decoder.decode(Detail.self, from: data)
                    DispatchQueue.main.async {
                        self.delegate?.detailsLoaded(pharmacy: details)
                    }
                }
            }
            dataTask.resume()
        }
    }

}
