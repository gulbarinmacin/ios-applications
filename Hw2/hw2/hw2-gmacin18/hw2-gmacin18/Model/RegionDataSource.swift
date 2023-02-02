//
//  RegionDataSource.swift
//  hw2-gmacin18
//
//  Created by Lab on 27.11.2022.
//

import Foundation
class RegionDataSource{
    
    private let baseURL = "https://koc.api.staging.tarentum.io"
    var delegate: DataSourceDelegate?
    private var regionArray: [Region] = []
    
    func getListOfRegions(cityId: Int) {
        let urlSession = URLSession.shared
        if let url = URL(string: "\(baseURL)/city/\(cityId)/region") {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let dataTask = urlSession.dataTask(with: urlRequest) { data, response, error in
                let decoder = JSONDecoder()
                if let data = data {
                    let regions = try! decoder.decode([Region].self, from: data)
                    self.regionArray = regions
                    DispatchQueue.main.async {
                        self.delegate?.regionListLoaded(region: regions)
                    }
                }
            }
            dataTask.resume()
        }
    }
    
    func getRegion(index: Int) -> Region {
        return regionArray[index]
    }
    
     
    func getNumberOfRegions() -> Int {
        return regionArray.count
    }
    
    func getRegion(for index: Int) -> Region? {
        guard index < regionArray.count else {
            return nil
        }
        
        return  regionArray[index]
    }
}
