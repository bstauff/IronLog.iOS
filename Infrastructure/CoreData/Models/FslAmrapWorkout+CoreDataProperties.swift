//
//  FslAmrapWorkout+CoreDataProperties.swift
//  Ironlog
//
//  Created by Brian Stauff on 3/10/23.
//
//

import Foundation
import CoreData


extension FslAmrapWorkout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FslAmrapWorkout> {
        return NSFetchRequest<FslAmrapWorkout>(entityName: "FslAmrapWorkout")
    }

    @NSManaged public var recordReps: Int32

}
