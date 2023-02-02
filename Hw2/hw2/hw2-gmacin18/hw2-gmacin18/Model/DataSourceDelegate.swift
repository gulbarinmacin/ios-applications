//
//  DataSourceDelegate.swift
//  hw2-gmacin18
//
//  Created by Lab on 27.11.2022.
//

import Foundation
protocol DataSourceDelegate {
    func cityListLoaded()
    func regionListLoaded(region: [Region])
    func pharmacyListLoaded(pharmacy: [Pharmacy])
    func detailsLoaded(pharmacy: Detail)
}

extension DataSourceDelegate {
    func cityListLoaded() {}
    func regionListLoaded(region: [Region]) {}
    func pharmacyListLoaded(pharmacy: [Pharmacy]) {}
    func detailsLoaded(pharmacy: Detail) {}
}
