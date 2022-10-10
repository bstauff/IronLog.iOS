//
//  LiftRepository.swift
//  Ironlog
//
//  Created by Brian Stauff on 5/21/22.
//

import Foundation

protocol AppRepository {
    func getLift(liftId: UUID) throws -> Lift?
    func getAllLifts() throws -> [Lift]
    func addLift(lift: Lift) throws
    func deleteLift(liftId: UUID) throws
    func saveLift(lift: Lift) throws
    func getWorkout(workoutId: UUID) throws -> Workout?
    func getAllWorkouts() throws -> [Workout]
    func addWorkout(workout: Workout) throws
    func deleteWorkout(workoutId: UUID) throws
    func saveWorkout(workout: Workout) throws
}
