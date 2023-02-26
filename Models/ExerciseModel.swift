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
    
    init(isComplete: Bool, lift: LiftModel, sets: [ExerciseSetModel]) {
        self.isComplete = isComplete
        self.lift = lift
        self.sets = sets
    }
}
