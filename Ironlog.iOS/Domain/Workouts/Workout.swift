//
//  Workout.swift
//  IronlogTests
//
//  Created by Brian Stauff on 1/30/22.
//

import Foundation

class Workout : ObservableObject, Identifiable {
    let id: UUID
    @Published var date: Date
    @Published var exercises: [Exercise]
    @Published var isComplete = false
    init(date: Date) {
        self.date = date
        id = UUID()
        self.exercises = []
    }
}
