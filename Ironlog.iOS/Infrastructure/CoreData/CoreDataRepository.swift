//
//  CoreDataLiftRepository.swift
//  Ironlog
//
//  Created by Brian Stauff on 5/21/22.
//

import Foundation
import CoreData

class CoreDataRepository : AppRepository{
    
    private let container = NSPersistentContainer(name: "Ironlog")
    
    init() {
        container.loadPersistentStores { description, error in
            if error != nil {
                print("failed to init core data")
            }
        }
    }
    
    func getLift(liftId: UUID) throws -> Lift? {
        let liftModel = try fetchLiftById(liftId)
            
        guard liftModel != nil else {
            return nil
        }
        
        return
            Lift(
                name: liftModel!.name!,
                trainingMax: Int(liftModel!.trainingMax),
                id: liftModel!.id!)
    }
    
    func getAllLifts() throws -> [Lift] {
        let fetchRequest = LiftModel.fetchRequest()
        let lifts = try container.viewContext.fetch(fetchRequest)

        var results: [Lift] = []

        for liftModel in lifts {
            let trainingMax = liftModel.trainingMax
            let name = liftModel.name
            let id = liftModel.id

            guard name != nil else {
                continue
            }

            guard id != nil else {
                continue
            }

            let liftToAdd = Lift(name: name!, trainingMax: Int(trainingMax), id: id!)
            results.append(liftToAdd)
        }

        return results
    }
    
    
    
    func addLift(lift: Lift) throws {
        let liftModel = LiftModel(context: container.viewContext)
        liftModel.name = lift.name
        liftModel.trainingMax = Int64(lift.trainingMax)
        liftModel.id = lift.id
        try container.viewContext.save()
    }
    
    func deleteLift(liftId: UUID) throws {
        let liftToDelete = try fetchLiftById(liftId)
        
        guard liftToDelete != nil else {
            return
        }
        
        container.viewContext.delete(liftToDelete!)
        
        try container.viewContext.save()
    }
    
    func saveLift(lift: Lift) throws {
        let liftToUpdate = try fetchLiftById(lift.id)
        
        guard liftToUpdate != nil else {
            throw CoreDataLiftRepositoryError.noExistingLiftForUpdate
        }
        
        liftToUpdate!.name = lift.name
        liftToUpdate!.trainingMax = Int64(lift.trainingMax)
        try container.viewContext.save()
    }
    
    func getWorkout(workoutId: UUID) throws -> Workout? {
        
        let workoutModel = try fetchWorkoutById(workoutId)
            
        guard workoutModel != nil else {
            return nil
        }
            
        return try mapWorkoutModel(workoutModel: workoutModel!)
    }
    
    func getAllWorkouts() throws -> [Workout] {
        let fetchRequest = WorkoutModel.fetchRequest()
        let workouts = try container.viewContext.fetch(fetchRequest)

        var results: [Workout] = []

        for workoutModel in workouts {
            let mappedWorkout = try mapWorkoutModel(workoutModel: workoutModel)
            results.append(mappedWorkout)
        }

        return results
    }
    
    func getWorkoutForDate(date: Date) throws -> Workout? {
        let fetchRequest = WorkoutModel.fetchRequest()
        let fetchPred = NSPredicate(format: "%K == %@","date", date as CVarArg)
        fetchRequest.predicate = fetchPred
        
        let workouts = try container.viewContext.fetch(fetchRequest)
        
        if(workouts.count > 0) {
            
            return try mapWorkoutModel(workoutModel: workouts[0])
        }
        return nil
    }
    
    func saveWorkout(workout: Workout) throws {
        try deleteWorkout(workoutId: workout.id)
        try addWorkout(workout: workout)
    }
    
    func deleteWorkout(workoutId: UUID) throws {
        let workoutToDelete = try fetchWorkoutById(workoutId)
        
        guard workoutToDelete != nil else {
            return
        }
        
        container.viewContext.delete(workoutToDelete!)
        
        try container.viewContext.save()
    }
    
    func addWorkout(workout: Workout) throws {
        let _ = try mapWorkout(workout: workout)
        
        try container.viewContext.save()
    }
    
    
    //fetch for lifts
    private func fetchLiftById(_ liftId: UUID) throws -> LiftModel? {
        let fetchRequest = LiftModel.fetchRequest()
        let fetchPred = NSPredicate(format: "%K == %@","id", liftId as CVarArg)
        fetchRequest.predicate = fetchPred
            
        let lifts = try container.viewContext.fetch(fetchRequest)
        if(lifts.count > 1) {
            throw CoreDataLiftRepositoryError.duplicateLiftsForId
        }
        
        if(lifts.count == 0) {
            return nil
        }
            
        return lifts[0]
        
    }
    
    //mappers for lift models
    private func mapLiftModel(liftModel: LiftModel) throws -> Lift {
        guard liftModel.id != nil else {
            throw CoreDataLiftRepositoryError.entityHasBadId
        }
        
        return Lift(
            name: liftModel.name ?? "",
            trainingMax: Int(liftModel.trainingMax),
            id: liftModel.id!
        )
    }
    
    //fetch for workouts
    private func fetchWorkoutById(_ workoutId: UUID) throws -> WorkoutModel? {
        let fetchRequest = WorkoutModel.fetchRequest()
        let fetchPred = NSPredicate(format: "%K == %@","id", workoutId as CVarArg)
        fetchRequest.predicate = fetchPred
            
        let workouts = try container.viewContext.fetch(fetchRequest)
        if(workouts.count > 1) {
            throw CoreDataLiftRepositoryError.duplicateWorkoutsForId
        }
        
        if(workouts.count == 0) {
            return nil
        }
        
        return workouts[0]
    }
    
    //mappers for workout models
    private func mapWorkoutModel(workoutModel: WorkoutModel) throws -> Workout {
        
        var exercises: [Exercise] = []
        
        for exerciseModel in workoutModel.workoutExercise as? Set<ExerciseModel> ?? [] {
            let mappedExercise = try mapExerciseModel(exerciseModel: exerciseModel)
            
            exercises.append(mappedExercise)
        }
        
        return Workout(
            id: workoutModel.id!,
            date: workoutModel.date!,
            exercises: exercises,
            isComplete: workoutModel.isComplete
        )
    }
    
    private func mapExerciseModel(exerciseModel: ExerciseModel) throws -> Exercise {
        
        guard exerciseModel.id != nil else {
            throw CoreDataLiftRepositoryError.entityHasBadId
        }
        
        let mappedLift = try mapLiftModel(liftModel: exerciseModel.exerciseLift!)
        
        var mappedSets: [ExerciseSet] = []
        
        for setModel in exerciseModel.exerciseSets as? Set<ExerciseSetModel> ?? [] {
            mappedSets.append(try mapExerciseSetModel(exerciseSetModel: setModel))
        }
        
        return Exercise(id: exerciseModel.id!, sets: mappedSets, lift: mappedLift, isComplete: exerciseModel.isComplete)
    }
    
    
    private func mapExerciseSetModel(exerciseSetModel: ExerciseSetModel) throws -> ExerciseSet {
        guard exerciseSetModel.id != nil else {
            throw CoreDataLiftRepositoryError.entityHasBadId
        }
        return ExerciseSet(
            reps: Int(exerciseSetModel.reps),
            weight: Int(exerciseSetModel.weight),
            id: exerciseSetModel.id!)
    }
    
    private func mapWorkout(workout: Workout) throws -> WorkoutModel {
        var exerciseModels: [ExerciseModel] = []
        
        for exercise in workout.exercises {
            let mappedExercise = try mapExercise(exercise: exercise)
            exerciseModels.append(mappedExercise)
        }
        
        let nsExerciseSet = NSSet(array: exerciseModels)
        
        let workoutModel = WorkoutModel(context: self.container.viewContext)
        
        workoutModel.id = workout.id
        workoutModel.isComplete = workout.isComplete
        workoutModel.date = workout.date
        workoutModel.workoutExercise = nsExerciseSet
        
        return workoutModel
    }
    
    private func mapExercise(exercise: Exercise) throws -> ExerciseModel {
        let liftModel = try fetchLiftById(exercise.lift.id)
        
        guard liftModel != nil else {
            throw CoreDataLiftRepositoryError.noExistingLiftForUpdate
        }
            
        var exerciseSets: [ExerciseSetModel] = []
        
        for exerciseSet in exercise.sets {
            exerciseSets.append(try mapExerciseSet(exerciseSet: exerciseSet))
        }
        
        let nsExerciseSets = NSSet(array: exerciseSets)
            
        let mappedExercise = ExerciseModel(context: self.container.viewContext)
        
        mappedExercise.id = exercise.id
        mappedExercise.exerciseSets = nsExerciseSets
        mappedExercise.exerciseLift = liftModel
        mappedExercise.isComplete = exercise.isComplete
        
        return mappedExercise
    }
    
    private func mapExerciseSet(exerciseSet: ExerciseSet) throws -> ExerciseSetModel {
        let exerciseSetModel = ExerciseSetModel(context: self.container.viewContext)
        exerciseSetModel.id = exerciseSet.id
        exerciseSetModel.isComplete = exerciseSet.isComplete
        exerciseSetModel.weight = Int64(exerciseSet.weight)
        exerciseSetModel.reps = Int64(exerciseSet.reps)
        
        return exerciseSetModel
    }
    
    
}

enum CoreDataLiftRepositoryError : Error {
    case duplicateLiftsForId
    case noExistingLiftForUpdate
    case duplicateWorkoutsForId
    case entityHasBadId
}
