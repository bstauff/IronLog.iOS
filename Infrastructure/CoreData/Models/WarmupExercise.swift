//
//  WarmupExercise+CoreDataClass.swift
//  Ironlog
//
//  Created by Brian Stauff on 3/10/23.
//
//

import Foundation
import CoreData

@objc(WarmupExercise)
public class WarmupExercise: Exercise {
    private var repsAndMultipliers = [(5, 0.40), (5, 0.50), (3, 0.60)]
    
    override func planSetsForWeek(week: CycleWeek) {
        for (reps, mult) in self.repsAndMultipliers {
            let adjustedWeight = self.lift!.getAdjustedTrainingMax(multiplier: mult)
            
            let newSet = ExerciseSet(context: self.managedObjectContext!)
            
            newSet.reps = Int32(reps)
            newSet.weight = Int32(adjustedWeight)
            
            self.addToExerciseSets(newSet)
        }
    }
}
