//
//  SupplementalExercise+CoreDataClass.swift
//  Ironlog
//
//  Created by Brian Stauff on 3/10/23.
//
//

import Foundation
import CoreData

@objc(SupplementalExercise)
public class SupplementalExercise: Exercise {
    private var weeksToMultipliers = [
        CycleWeek.firstWeek: 0.65,
        CycleWeek.secondWeek: 0.70,
        CycleWeek.thirdWeek: 0.75
    ]
    
    override func planSetsForWeek(week: CycleWeek) {
        let multiplier = self.weeksToMultipliers[week]
        
        for _ in 1...5 {
            let adjustedWeight = self.lift!.getAdjustedTrainingMax(multiplier: multiplier!)
            
            let newSet = ExerciseSet(context: self.managedObjectContext!)
            newSet.reps = 5
            newSet.weight = Int32(adjustedWeight)
            
            self.addToExerciseSets(newSet)
        }
    }
}
