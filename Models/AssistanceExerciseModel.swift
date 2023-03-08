//
//  AssistanceExerciseModel.swift
//  Ironlog
//
//  Created by Brian Stauff on 3/8/23.
//

import Foundation

class AssistanceExerciseModel: ExerciseModel {
    override func planSetsForWeek(week: CycleWeek) {
        for _ in 1 ... 5 {
            let newSet = ExerciseSetModel(reps: 5, weight: self.lift.trainingMax)
            self.sets.append(newSet)
        }
    }
}
