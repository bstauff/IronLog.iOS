//
//  MainExercise+CoreDataProperties.swift
//  Ironlog
//
//  Created by Brian Stauff on 3/10/23.
//
//

import Foundation
import CoreData


extension MainExercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MainExercise> {
        return NSFetchRequest<MainExercise>(entityName: "MainExercise")
    }

    @NSManaged public var workout: Workout?

}
