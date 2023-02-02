//
//  GameViewModel.swift
//  gmacin18-hw3
//
//  Created by User on 4.01.2023.
//

import SwiftUI

class  GameViewModel: ObservableObject {
    private let gameHelper = GameHelper()
    @Published var shownNames = [String]()
    @Published var buttonTitle = "DRAW"
    

    init(){
        gameHelper.delegate = self
    }
    
    func drawNames(){
        let name = gameHelper.createName()
        if shownNames.contains(name) == false{
            shownNames.append(name)
        }
    
        if shownNames.count == 3
        {
            buttonTitle = "CLEAR"
        }
        else if shownNames.count > 3{
            resetUI()
            buttonTitle = "DRAW"
        }
    }
}

extension GameViewModel: GameDelegate {
    func resetUI() {
        shownNames.removeAll()
    }
}
