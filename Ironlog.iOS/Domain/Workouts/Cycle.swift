//
//  Cycle.swift
//  IronlogTests
//
//  Created by Brian Stauff on 1/30/22.
//

import Foundation

class Cycle : ObservableObject, Identifiable {
    var id: UUID
    @Published var workouts: [Workout]
    
    init(){
        self.id = UUID()
        self.workouts = []
    }
    
    func getActiveWorkout() -> Workout? {
        
        return workouts
                .filter {
                    return
                        Calendar(identifier: .gregorian)
                        .isDateInToday($0.date)
                }
                .first
        
    }
    func doesCycleHaveWorkoutForDate(date: Date) -> Bool {
        return workouts
            .contains {
                Calendar(identifier: .gregorian)
                    .isDateInToday($0.date)
            }
    }
}
