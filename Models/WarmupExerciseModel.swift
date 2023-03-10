//
//  WarmupExerciseModel.swift
//  Ironlog
//
//  Created by Brian Stauff on 3/8/23.
//

import Foundation

class WarmupExerciseModel: ExerciseModel {
    private var repsAndMultipliers = [(5, 0.40), (5, 0.50), (3, 0.60)]
    
    override func planSetsForWeek(week: CycleWeek) {
        for (reps, mult) in self.repsAndMultipliers {
            let adjustedWeight = self.lift.getAdjustedTrainingMax(multiplier: mult)
            
            let newSet = ExerciseSetModel(
                reps: reps,
                weight: adjustedWeight
            )
            sets.append(newSet)
        }
    }
}
