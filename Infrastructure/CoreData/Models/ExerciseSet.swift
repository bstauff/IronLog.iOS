//
//  ExerciseSet+CoreDataClass.swift
//  Ironlog
//
//  Created by Brian Stauff on 3/10/23.
//
//

import Foundation
import CoreData

@objc(ExerciseSet)
public class ExerciseSet: NSManagedObject {
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        self.id = UUID()
        self.isComplete = false
    }
}
