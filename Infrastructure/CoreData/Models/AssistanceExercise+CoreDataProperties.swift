//
//  AssistanceExercise+CoreDataProperties.swift
//  Ironlog
//
//  Created by Brian Stauff on 3/10/23.
//
//

import Foundation
import CoreData


extension AssistanceExercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AssistanceExercise> {
        return NSFetchRequest<AssistanceExercise>(entityName: "AssistanceExercise")
    }

    @NSManaged public var workout: Workout?

}
