//
//  MainExerciseModel.swift
//  Ironlog
//
//  Created by Brian Stauff on 3/8/23.
//

import Foundation

class MainExerciseModel: ExerciseModel {
    private var weeksToRepsAndMultipliers = [
        CycleWeek.firstWeek: [(5, 0.65), (5, 0.75), (5, 0.85)],
        CycleWeek.secondWeek: [(3, 0.70), (3, 0.80), (3, 0.90)],
        CycleWeek.thirdWeek: [(5, 0.75),(3, 0.85),(1, 0.95)]
    ]
    
    override func planSetsForWeek(week: CycleWeek) {
       let repsMults = self.weeksToRepsAndMultipliers[week]
        
        for (reps, mult) in repsMults! {
            let adjustedWeight = self.lift.getAdjustedTrainingMax(multiplier: mult)
            
            let newSet = ExerciseSetModel(
                reps: reps,
                weight: adjustedWeight
            )
            sets.append(newSet)
        }
    }
}
