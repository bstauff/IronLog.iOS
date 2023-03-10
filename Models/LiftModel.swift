//
//  LiftModel.swift
//  Ironlog
//
//  Created by Brian Stauff on 2/25/23.
//

import Foundation

struct LiftModel {
    var name: String
    var trainingMax: Int
    var isMainLift: Bool
    
    init(name: String, trainingMax: Int, isMainLift: Bool) {
        self.name = name
        self.trainingMax = trainingMax
        self.isMainLift = isMainLift
    }
    
    func getAdjustedTrainingMax(multiplier: Double) -> Int {
        let liftTrainingMax = Double(self.trainingMax)
        
        let scaledWeight = (liftTrainingMax * multiplier) / 5
        
        let scaledWeightRounded = 5 * scaledWeight.rounded(.toNearestOrAwayFromZero)
        
        return Int(scaledWeightRounded)
    }
}
