//
//  SupplementalExerciseModel.swift
//  Ironlog
//
//  Created by Brian Stauff on 3/8/23.
//

import Foundation

class SupplementalExerciseModel: ExerciseModel {
    private var weeksToMultipliers = [
        CycleWeek.firstWeek: 0.65,
        CycleWeek.secondWeek: 0.70,
        CycleWeek.thirdWeek: 0.75
    ]
    
    override func planSetsForWeek(week: CycleWeek) {
        let multiplier = self.weeksToMultipliers[week]
        
        for _ in 1...5 {
            let adjustedWeight = self.lift.getAdjustedTrainingMax(multiplier: multiplier!)
            
            let newSet = ExerciseSetModel(
                reps: 5,
                weight: adjustedWeight
            )
            sets.append(newSet)
        }
    }
}
