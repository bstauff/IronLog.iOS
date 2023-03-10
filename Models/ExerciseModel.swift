//
//  ExerciseModel.swift
//  Ironlog
//
//  Created by Brian Stauff on 2/25/23.
//

import Foundation

class ExerciseModel: ObservableObject {
    @Published
    var isComplete: Bool
    @Published
    var lift: LiftModel
    @Published
    var sets: [ExerciseSetModel]
    
    required init(lift: LiftModel) {
        self.isComplete = false
        self.lift = lift
        self.sets = []
    }
    
    func planSetsForWeek(week: CycleWeek) {
        self.sets = []
    }
}
