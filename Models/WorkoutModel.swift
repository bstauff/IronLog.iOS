//
//  WorkoutModel.swift
//  Ironlog
//
//  Created by Brian Stauff on 2/25/23.
//

import Foundation

class WorkoutModel : ObservableObject {
    @Published
    var warmupExercises: [ExerciseModel] = []
    
    @Published
    var mainExercise: ExerciseModel
    
    @Published
    var supplementalExercise: ExerciseModel
    
    @Published
    var assistanceExercises: [ExerciseModel] = []
    
    init(mainLift: LiftModel, date: Date, workoutWeek: WorkoutWeeks) {
        let mainSets = WorkoutModel.createMainSetsForWeek(lift: mainLift, week: workoutWeek)
        self.mainExercise = ExerciseModel(isComplete: false, lift: mainLift, sets: mainSets)
        let supplementalSets = WorkoutModel.createSupplementalSetsForWeek(lift: mainLift, week: workoutWeek)
        self.supplementalExercise = ExerciseModel(isComplete: false, lift: mainLift, sets: supplementalSets)
    }
    
    private static func createMainSetsForWeek(lift: LiftModel, week: WorkoutWeeks) -> [ExerciseSetModel] {
        switch week {
        case WorkoutWeeks.firstWeek:
            let set1Reps = 5
            let set2Reps = 5
            let set3Reps = 5
            
            let set1Multiplier: Double = 0.65
            let set1Weight = getTrainingMaxWeight(trainingMax: lift.trainingMax, multiplier: set1Multiplier)
            let set2Multiplier: Double = 0.75
            let set2Weight = getTrainingMaxWeight(trainingMax: lift.trainingMax, multiplier: set2Multiplier)
            let set3Multiplier: Double = 0.85
            let set3Weight = getTrainingMaxWeight(trainingMax: lift.trainingMax, multiplier: set3Multiplier)
            
            var exerciseSets: [ExerciseSetModel] = []
            
            exerciseSets.append(ExerciseSetModel(isComplete: false, reps: set1Reps, weight: set1Weight))
            exerciseSets.append(ExerciseSetModel(isComplete: false, reps: set2Reps, weight: set2Weight))
            exerciseSets.append(ExerciseSetModel(isComplete: false, reps: set3Reps, weight: set3Weight))
            return exerciseSets
        case WorkoutWeeks.secondWeek:
            let set1Reps = 3
            let set2Reps = 3
            let set3Reps = 3
            
            let set1Multiplier: Double = 0.70
            let set1Weight = getTrainingMaxWeight(trainingMax: lift.trainingMax, multiplier: set1Multiplier)
            let set2Multiplier: Double = 0.80
            let set2Weight = getTrainingMaxWeight(trainingMax: lift.trainingMax, multiplier: set2Multiplier)
            let set3Multiplier: Double = 0.90
            let set3Weight = getTrainingMaxWeight(trainingMax: lift.trainingMax, multiplier: set3Multiplier)
            
            var exerciseSets: [ExerciseSetModel] = []
            
            exerciseSets.append(ExerciseSetModel(isComplete: false, reps: set1Reps, weight: set1Weight))
            exerciseSets.append(ExerciseSetModel(isComplete: false, reps: set2Reps, weight: set2Weight))
            exerciseSets.append(ExerciseSetModel(isComplete: false, reps: set3Reps, weight: set3Weight))
            return exerciseSets
        case WorkoutWeeks.thirdWeek:
            let set1Reps = 5
            let set2Reps = 3
            let set3Reps = 1
            
            let set1Multiplier: Double = 0.75
            let set1Weight = getTrainingMaxWeight(trainingMax: lift.trainingMax, multiplier: set1Multiplier)
            let set2Multiplier: Double = 0.85
            let set2Weight = getTrainingMaxWeight(trainingMax: lift.trainingMax, multiplier: set2Multiplier)
            let set3Multiplier: Double = 0.95
            let set3Weight = getTrainingMaxWeight(trainingMax: lift.trainingMax, multiplier: set3Multiplier)
            
            var exerciseSets: [ExerciseSetModel] = []
            
            exerciseSets.append(ExerciseSetModel(isComplete: false, reps: set1Reps, weight: set1Weight))
            exerciseSets.append(ExerciseSetModel(isComplete: false, reps: set2Reps, weight: set2Weight))
            exerciseSets.append(ExerciseSetModel(isComplete: false, reps: set3Reps, weight: set3Weight))
            return exerciseSets
        }
    }
    
    private static func createSupplementalSetsForWeek(lift: LiftModel, week: WorkoutWeeks) -> [ExerciseSetModel] {
        let setWeight: Int
        let multiplier: Double
        
        switch week {
        case WorkoutWeeks.firstWeek:
            multiplier = 0.65
        case WorkoutWeeks.secondWeek:
            multiplier = 0.70
        case WorkoutWeeks.thirdWeek:
            multiplier = 0.75
        }
        setWeight = getTrainingMaxWeight(trainingMax: lift.trainingMax, multiplier: multiplier)
        var exerciseSets: [ExerciseSetModel] = []
        for _ in 0...4 {
            exerciseSets.append(ExerciseSetModel(isComplete: false, reps: 5, weight: setWeight))
        }
        
        return exerciseSets
    }
    
    
    private static func getTrainingMaxWeight(trainingMax: Int, multiplier: Double) -> Int {
        let liftTrainingMax = Double(trainingMax)
        
        let scaledWeight = (liftTrainingMax * multiplier) / 5
        
        let scaledWeightRounded = 5 * scaledWeight.rounded(.toNearestOrAwayFromZero)
        
        return Int(scaledWeightRounded)
        
    }
}
