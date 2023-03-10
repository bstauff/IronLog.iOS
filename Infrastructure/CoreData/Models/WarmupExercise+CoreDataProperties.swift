//
//  WarmupExercise+CoreDataProperties.swift
//  Ironlog
//
//  Created by Brian Stauff on 3/10/23.
//
//

import Foundation
import CoreData


extension WarmupExercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WarmupExercise> {
        return NSFetchRequest<WarmupExercise>(entityName: "WarmupExercise")
    }

    @NSManaged public var workout: Workout?

}
