//
//  SupplementalExercise+CoreDataProperties.swift
//  Ironlog
//
//  Created by Brian Stauff on 3/10/23.
//
//

import Foundation
import CoreData


extension SupplementalExercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SupplementalExercise> {
        return NSFetchRequest<SupplementalExercise>(entityName: "SupplementalExercise")
    }

    @NSManaged public var workout: Workout?

}
