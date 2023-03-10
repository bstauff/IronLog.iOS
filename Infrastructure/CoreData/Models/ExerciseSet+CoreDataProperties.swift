//
//  ExerciseSet+CoreDataProperties.swift
//  Ironlog
//
//  Created by Brian Stauff on 3/10/23.
//
//

import Foundation
import CoreData


extension ExerciseSet {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseSet> {
        return NSFetchRequest<ExerciseSet>(entityName: "ExerciseSet")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isComplete: Bool
    @NSManaged public var reps: Int32
    @NSManaged public var weight: Int32
    @NSManaged public var exercise: Exercise?

}

extension ExerciseSet : Identifiable {

}
