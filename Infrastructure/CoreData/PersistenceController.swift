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
        
        let dumbbellBench = Lift(context: viewContext)
        dumbbellBench.id = UUID()
        dumbbellBench.name = "Dumbbell Bench"
        dumbbellBench.trainingMax = 75
        
        let latPulldown = Lift(context: viewContext)
        latPulldown.id = UUID()
        latPulldown.name = "Lat Pulldown"
        latPulldown.trainingMax = 115
        
        let reverseCrunch = Lift(context: viewContext)
        reverseCrunch.id = UUID()
        reverseCrunch.name = "Reverse Crunch"
        reverseCrunch.trainingMax = 200
        
        let workout = Workout(context: viewContext)
        workout.id = UUID()
        workout.isComplete = false
        workout.date = Date()
        
        let warmUp = WarmupExercise(context: viewContext)
        warmUp.isComplete = false
        warmUp.id = UUID()
        warmUp.lift = squat
        
        warmUp.exerciseSets = createSets(setCount: 3, viewContext: viewContext)
        
        workout.addToWarmupExercises(warmUp)
            
        let main = MainExercise(context: viewContext)
        main.isComplete = false
        main.id = UUID()
        main.lift = squat
        main.exerciseSets = createSets(setCount: 3, viewContext: viewContext)
        
        workout.mainExercise = main
        
        let supplemental = SupplementalExercise(context: viewContext)
        supplemental.isComplete = false
        supplemental.id = UUID()
        supplemental.lift = squat
        supplemental.exerciseSets = createSets(setCount: 5, viewContext: viewContext)
        
        workout.supplementalExercise = supplemental
        
        let assistance1 = AssistanceExercise(context: viewContext)
        assistance1.isComplete = false
        assistance1.id = UUID()
        assistance1.lift = dumbbellBench
        assistance1.exerciseSets = createSets(setCount: 5, viewContext: viewContext)
        
        let assistance2 = AssistanceExercise(context: viewContext)
        assistance2.isComplete = false
        assistance2.id = UUID()
        assistance2.lift = latPulldown
        assistance2.exerciseSets = createSets(setCount: 5, viewContext: viewContext)
        
        let assistance3 = AssistanceExercise(context: viewContext)
        assistance3.isComplete = false
        assistance3.id = UUID()
        assistance3.lift = reverseCrunch
        assistance3.exerciseSets = createSets(setCount: 5, viewContext: viewContext)
        
        var assistanceWork = NSOrderedSet(array: [assistance1, assistance2, assistance3])
        
        workout.assistanceExercises = assistanceWork
        
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
    
    private static func createSets(setCount: Int, viewContext: NSManagedObjectContext) -> NSOrderedSet {
        var sets: [ExerciseSet] = []
        
        for _ in 1...setCount {
            let set = ExerciseSet(context: viewContext)
            set.id = UUID()
            set.isComplete = false
            set.weight = Int32(Int.random(in: 200..<300))
            set.reps = Int32(Int.random(in: 1...5))
            
            sets.append(set)
        }
        
        return NSOrderedSet(array: sets)
    }
}
