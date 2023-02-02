//
//  GameHelper.swift
//  gmacin18-hw3
//
//  Created by User on 4.01.2023.
//

import Foundation

class GameHelper {
    weak var delegate: GameDelegate?
    
    let nameList = ["Ali", "Ayşe", "Ahmet", "Fatma", "Hatice", "Mehmet", "Oğuz", "Mert", "Furkan", "Aslı"]
    
    func createName() -> String {
        let rname = nameList.randomElement()!
        return rname
    }
}
