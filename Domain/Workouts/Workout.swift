//
//  Workout.swift
//  IronlogTests
//
//  Created by Brian Stauff on 1/30/22.
//

import Foundation

class Workout : ObservableObject, Identifiable, Hashable {
    
    let id: UUID
    @Published var date: Date
    @Published var exercises: [Exercise]
    @Published var isComplete = false
    init(date: Date) {
        self.date = date
        id = UUID()
        self.exercises = []
    }
    
    init(id: UUID, date: Date, exercises: [Exercise], isComplete: Bool){
        self.id = id
        self.date = date
        self.exercises = exercises
        self.isComplete = isComplete
    }
    
    static func == (lhs: Workout, rhs: Workout) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(date)
        hasher.combine(exercises)
        hasher.combine(isComplete)
    }
    
}
