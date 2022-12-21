//
//  PersistenceController.swift
//  Ironlog
//
//  Created by Brian Stauff on 12/1/22.
//

import Foundation
import CoreData

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    
    static var preview: PersistenceController = {
        let controller = PersistenceController(inMemory: true)
        
        let viewContext = controller.container.viewContext
        
        let squat = LiftModel(context: viewContext)
        squat.name = "Squat"
        squat.trainingMax = 315
        squat.id = UUID()
        
        let bench = LiftModel(context: viewContext)
        bench.name = "Bench"
        bench.trainingMax = 375
        bench.id = UUID()
        
        let workout = WorkoutModel(context: viewContext)
        workout.id = UUID()
        workout.date = Date()
        workout.isComplete = false
        
        let anotherWorkout = WorkoutModel(context: viewContext)
        anotherWorkout.id = UUID()
        anotherWorkout.date = Calendar.current.date(byAdding:.day, value: 5, to: Date())
        anotherWorkout.isComplete = false
            
        let workoutSet1 = ExerciseSetModel(context: viewContext)
        workoutSet1.isComplete = false
        workoutSet1.id = UUID()
        workoutSet1.weight = 250
        workoutSet1.reps = 5
        
        let workoutSet2 = ExerciseSetModel(context: viewContext)
        workoutSet2.isComplete = false
        workoutSet2.id = UUID()
        workoutSet2.weight = 275
        workoutSet2.reps = 3
        
        let workoutSet3 = ExerciseSetModel(context: viewContext)
        workoutSet3.isComplete = false
        workoutSet3.id = UUID()
        workoutSet3.weight = 275
        workoutSet3.reps = 3
        
        let workoutSets = [workoutSet1, workoutSet2, workoutSet3]
        
        let workoutExercise = ExerciseModel(context: viewContext)
        workoutExercise.id = UUID()
        workoutExercise.isComplete = false
        workoutExercise.exerciseLift = bench
        workoutExercise.exerciseSets = NSOrderedSet(array: workoutSets)
        
        workout.workoutExercises = [workoutExercise]
        anotherWorkout.workoutExercises = [workoutExercise]
            
        do {
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        
        return controller
    }()
    
    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Ironlog")
        
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { description, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
