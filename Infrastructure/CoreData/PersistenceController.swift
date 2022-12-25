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
        
        let squat = Lift(context: viewContext)
        squat.id = UUID()
        squat.name = "Squat"
        squat.trainingMax = 315
        
        let workout = Workout(context: viewContext)
        workout.id = UUID()
        workout.isComplete = false
        workout.date = Date()
        
        let warmUp = WarmupExercise(context: viewContext)
        warmUp.workout = workout
        warmUp.isComplete = false
        warmUp.id = UUID()
        warmUp.lift = squat
        
        let set1 = ExerciseSet(context: viewContext)
        set1.id = UUID()
        set1.isComplete = false
        set1.reps = 5
        set1.weight = 275
        set1.exercise = warmUp
        
        let set2 = ExerciseSet(context: viewContext)
        set2.id = UUID()
        set2.isComplete = false
        set2.reps = 3
        set2.weight = 300
        set1.exercise = warmUp
        
        let set3 = ExerciseSet(context: viewContext)
        set3.id = UUID()
        set3.isComplete = false
        set3.reps = 1
        set3.weight = 315
        set3.exercise = warmUp
        
        var sets = NSOrderedSet(array: [set1, set2, set3])
        
        warmUp.exerciseSets = sets
        
        
        warmUp.workout = workout
        
        workout.addToWarmupExercises(warmUp)
        
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
