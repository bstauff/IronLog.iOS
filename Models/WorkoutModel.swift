//
//  WorkoutModel.swift
//  Ironlog
//
//  Created by Brian Stauff on 2/25/23.
//

import Foundation

class WorkoutModel : ObservableObject {
    @Published
    var warmupExercise: ExerciseModel
    
    @Published
    var mainExercise: ExerciseModel
    
    @Published
    var supplementalExercise: ExerciseModel
    
    @Published
    var assistanceExercises: [ExerciseModel] = []
    
    @Published
    var workoutDate: Date
    
    @Published
    var cycleWeek: CycleWeek
    
    init(workoutDate: Date, cycleWeek: CycleWeek, mainLift: LiftModel)  {
        self.workoutDate = workoutDate
        self.cycleWeek = cycleWeek
            
        self.warmupExercise = WorkoutModel.planExercise(lift: mainLift, cycleWeek: cycleWeek)
        self.mainExercise = WorkoutModel.planExercise(lift: mainLift, cycleWeek: cycleWeek)
        self.supplementalExercise = WorkoutModel.planExercise(lift: mainLift, cycleWeek: cycleWeek)
    }
    
    private static func planExercise<T: ExerciseModel>(lift: LiftModel, cycleWeek: CycleWeek) -> T {
        let exercise = T(lift: lift)
        exercise.planSetsForWeek(week: cycleWeek)
        return exercise
    }
    
    func planAssistanceExercise(assistanceLift: LiftModel) {
        let assistanceExercise: AssistanceExerciseModel =
            WorkoutModel.planExercise(lift: assistanceLift, cycleWeek: self.cycleWeek)
        
        self.assistanceExercises.append(assistanceExercise)
    }
}
