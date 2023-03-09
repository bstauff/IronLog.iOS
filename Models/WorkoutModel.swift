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
            
        self.warmupExercise = WorkoutModel.planWarmupExercise(warmupLift: mainLift, cycleWeek: cycleWeek)
        self.mainExercise = WorkoutModel.planMainExercise(mainLift: mainLift, cycleWeek: cycleWeek)
        self.supplementalExercise = WorkoutModel.planSupplementalExercise(supplementalLift: mainLift, cycleWeek: cycleWeek)
    }
    
    static func planWarmupExercise(warmupLift: LiftModel, cycleWeek: CycleWeek) -> WarmupExerciseModel {
        let warmupExercise = WarmupExerciseModel(lift: warmupLift)
        warmupExercise.planSetsForWeek(week: cycleWeek)
        return warmupExercise
    }
    
    static func planMainExercise(mainLift: LiftModel, cycleWeek: CycleWeek) -> MainExerciseModel {
        let mainExercise = MainExerciseModel(lift: mainLift)
        mainExercise.planSetsForWeek(week: cycleWeek)
        return mainExercise
    }
    
    static func planSupplementalExercise(supplementalLift: LiftModel, cycleWeek: CycleWeek) -> SupplementalExerciseModel {
        let supplementalExercise = SupplementalExerciseModel(lift: supplementalLift)
        supplementalExercise.planSetsForWeek(week: cycleWeek)
        return supplementalExercise
    }
    
    func planAssistanceExercise(assistanceLift: LiftModel) {
        let assistanceExercise = AssistanceExerciseModel(lift: assistanceLift)
        assistanceExercise.planSetsForWeek(week: self.cycleWeek)
        self.assistanceExercises.append(assistanceExercise)
    }
}
