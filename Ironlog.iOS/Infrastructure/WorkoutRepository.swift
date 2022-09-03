//
//  WorkoutRepository.swift
//  Ironlog
//
//  Created by Brian Stauff on 9/3/22.
//

import Foundation
protocol WorkoutRepository {
    func getWorkout(workoutId: UUID) throws -> Workout?
    func getAllWorkouts() throws -> [Workout]
    func getWorkoutForDate(date: Date) -> Workout?
    func addWorkout(workout: Workout) throws
    func deleteWorkout(workoutId: UUID) throws
    func saveWorkout(workou: Workout) throws
}
