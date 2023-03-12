//
//  Lift+CoreDataClass.swift
//  Ironlog
//
//  Created by Brian Stauff on 3/10/23.
//
//

import Foundation
import CoreData

@objc(Lift)
public class Lift: NSManagedObject {
    func getAdjustedTrainingMax(multiplier: Double) -> Int {
        let liftTrainingMax = Double(self.trainingMax)
        
        let scaledWeight = (liftTrainingMax * multiplier) / 5
        
        let scaledWeightRounded = 5 * scaledWeight.rounded(.toNearestOrAwayFromZero)
        
        return Int(scaledWeightRounded)
    }
}
