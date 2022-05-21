//
//  CoreDataLiftRepository.swift
//  Ironlog
//
//  Created by Brian Stauff on 5/21/22.
//

import Foundation
import CoreData

class CoreDataLiftRepository : LiftRepository {
    
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
    
    private func fetchLift(_ liftId: UUID) throws -> LiftModel? {
        let fetchRequest = LiftModel.fetchRequest()
        let fetchPred = NSPredicate(format: "id = @a", liftId.uuidString)
        fetchRequest.predicate = fetchPred
        
        let lifts = try fetchRequest.execute()
        
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
        
    }
    
}

enum CoreDataLiftRepositoryError : Error {
    case duplicateLiftsForId
    case noExistingLiftForUpdate
}
