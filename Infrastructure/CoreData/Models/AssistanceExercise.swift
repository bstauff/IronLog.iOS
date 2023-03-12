//
//  AssistanceExercise+CoreDataClass.swift
//  Ironlog
//
//  Created by Brian Stauff on 3/10/23.
//
//

import Foundation
import CoreData

@objc(AssistanceExercise)
public class AssistanceExercise: Exercise {
    override func planSetsForWeek(week: CycleWeek) {
        for _ in 1 ... 5 {
            let newSet = ExerciseSet(context: self.managedObjectContext!)
            newSet.id = UUID()
            newSet.isComplete = false
            newSet.reps = 5
            newSet.weight = self.lift!.trainingMax
                
            self.addToExerciseSets(newSet)
        }
    }
}
