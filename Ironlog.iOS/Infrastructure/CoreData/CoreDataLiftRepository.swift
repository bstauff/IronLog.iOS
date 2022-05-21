//
//  CoreDataLiftRepository.swift
//  Ironlog
//
//  Created by Brian Stauff on 5/21/22.
//

import Foundation
import CoreData

class CoreDataLiftRepository : LiftRepository{
    
    private let container = NSPersistentContainer(name: "Ironlog")
    
    init() {
        container.loadPersistentStores { description, error in
            if error != nil {
                print("failed to init core data")
            }
        }
    }
    
    func getLift(liftId: UUID) throws -> Lift? {
        let liftModel = try fetchLift(liftId)
            
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
    
    private func fetchLift(_ liftId: UUID) throws -> LiftModel? {
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
    
    func addLift(lift: Lift) throws {
        let liftModel = LiftModel(context: container.viewContext)
        liftModel.name = lift.name
        liftModel.trainingMax = Int64(lift.trainingMax)
        liftModel.id = lift.id
        try container.viewContext.save()
    }
    
    func deleteLift(liftId: UUID) throws {
        let liftToDelete = try fetchLift(liftId)
        
        guard liftToDelete != nil else {
            return
        }
        
        container.viewContext.delete(liftToDelete!)
        
        try container.viewContext.save()
    }
    
    func saveLift(lift: Lift) throws {
        let liftToUpdate = try fetchLift(lift.id)
        
        guard liftToUpdate != nil else {
            throw CoreDataLiftRepositoryError.noExistingLiftForUpdate
        }
        
        liftToUpdate!.name = lift.name
        liftToUpdate!.trainingMax = Int64(lift.trainingMax)
        try container.viewContext.save()
    }
    
}

enum CoreDataLiftRepositoryError : Error {
    case duplicateLiftsForId
    case noExistingLiftForUpdate
}
