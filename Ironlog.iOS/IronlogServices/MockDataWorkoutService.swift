//
//  MockDataWorkoutService.swift
//  Ironlog
//
//  Created by Brian Stauff on 11/6/21.
//

import Foundation

struct MockDataWorkoutService : WorkoutServiceProtocol {
    func getWorkouts() -> Workout {
        return Workout(
            mainMovement: Movement(
                movementName: "Squat",
                sets: [
                    Set(weight: 275, reps: 5),
                    Set(weight: 300, reps: 3),
                    Set(weight: 325, reps: 1)
                ]),
            supplementalMovement: Movement(
                movementName: "Hack Squat",
                sets: [
                    Set(weight: 225, reps: 5),
                    Set(weight: 225, reps: 5),
                    Set(weight: 225, reps: 5),
                    Set(weight: 225, reps: 5),
                    Set(weight: 225, reps: 5)
                ]),
            assistanceMovements: [
                Movement(
                    movementName: "Tricep Pushdown",
                    sets: [
                        Set(weight: 45, reps: 12),
                        Set(weight: 45, reps: 12),
                        Set(weight: 45, reps: 12),
                        Set(weight: 45, reps: 12),
                        Set(weight: 45, reps: 12)
                ]),
                Movement(
                    movementName: "Lat Pulldown",
                    sets: [
                        Set(weight: 135, reps: 12),
                        Set(weight: 135, reps: 12),
                        Set(weight: 135, reps: 12),
                        Set(weight: 135, reps: 12),
                        Set(weight: 135, reps: 12)
                ]),
                Movement(
                    movementName: "Lunge Squat",
                    sets: [
                        Set(weight: 135, reps: 12),
                        Set(weight: 135, reps: 12),
                        Set(weight: 135, reps: 12),
                        Set(weight: 135, reps: 12),
                        Set(weight: 135, reps: 12)
                ])
            ])
    }
}
