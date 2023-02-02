//
//  CityDataSource.swift
//  hw2-gmacin18
//
//  Created by Lab on 27.11.2022.
//

import Foundation
import UIKit

class CityDataSource {
    
    private var cityArray: [City] = []
    private let baseURL = "https://koc.api.staging.tarentum.io"
    var delegate: DataSourceDelegate?
    
    init() {
        
    }
    
    func getListOfCities() {
        let urlSession = URLSession.shared
        if let url = URL(string: "\(baseURL)/city") {
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = "GET"
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            let dataTask = urlSession.dataTask(with: urlRequest) { data, response, error in
                let decoder = JSONDecoder()
                if let data = data {
                    let citiesArrayFromNetwork = try! decoder.decode([City].self, from: data)
                    self.cityArray = citiesArrayFromNetwork
                    DispatchQueue.main.async {
                        self.delegate?.cityListLoaded()
                    }
                    
                }
            }
            dataTask.resume()
        }
    }
    
    func getCity(index: Int) -> City {
        return cityArray[index]
    }
    
    func getNumberOfCities() -> Int {
        return cityArray.count
    }
    
    func getCity(for index: Int) -> City? {
        guard index < cityArray.count else {
            return nil
        }
        
        return  cityArray[index]
    }
}
