//
//  MainExercise+CoreDataClass.swift
//  Ironlog
//
//  Created by Brian Stauff on 3/10/23.
//
//

import Foundation
import CoreData

@objc(MainExercise)
public class MainExercise: Exercise {
    private var weeksToRepsAndMultipliers = [
        CycleWeek.firstWeek: [(5, 0.65), (5, 0.75), (5, 0.85)],
        CycleWeek.secondWeek: [(3, 0.70), (3, 0.80), (3, 0.90)],
        CycleWeek.thirdWeek: [(5, 0.75),(3, 0.85),(1, 0.95)]
    ]
    override func planSetsForWeek(week: CycleWeek) {
       let repsMults = self.weeksToRepsAndMultipliers[week]
        
        for (reps, mult) in repsMults! {
            let adjustedWeight = self.lift?.getAdjustedTrainingMax(multiplier: mult)
            
            let newSet = ExerciseSet(context: self.managedObjectContext!)
            newSet.isComplete = false
            newSet.id = UUID()
            newSet.reps = Int32(reps)
            newSet.weight = Int32(adjustedWeight!)
            self.addToExerciseSets(newSet)
        }
    }
}
