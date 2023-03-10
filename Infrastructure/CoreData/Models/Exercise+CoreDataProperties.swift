//
//  Exercise+CoreDataProperties.swift
//  Ironlog
//
//  Created by Brian Stauff on 3/10/23.
//
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isComplete: Bool
    @NSManaged public var exerciseSets: NSOrderedSet?
    @NSManaged public var lift: Lift?

}

// MARK: Generated accessors for exerciseSets
extension Exercise {

    @objc(insertObject:inExerciseSetsAtIndex:)
    @NSManaged public func insertIntoExerciseSets(_ value: ExerciseSet, at idx: Int)

    @objc(removeObjectFromExerciseSetsAtIndex:)
    @NSManaged public func removeFromExerciseSets(at idx: Int)

    @objc(insertExerciseSets:atIndexes:)
    @NSManaged public func insertIntoExerciseSets(_ values: [ExerciseSet], at indexes: NSIndexSet)

    @objc(removeExerciseSetsAtIndexes:)
    @NSManaged public func removeFromExerciseSets(at indexes: NSIndexSet)

    @objc(replaceObjectInExerciseSetsAtIndex:withObject:)
    @NSManaged public func replaceExerciseSets(at idx: Int, with value: ExerciseSet)

    @objc(replaceExerciseSetsAtIndexes:withExerciseSets:)
    @NSManaged public func replaceExerciseSets(at indexes: NSIndexSet, with values: [ExerciseSet])

    @objc(addExerciseSetsObject:)
    @NSManaged public func addToExerciseSets(_ value: ExerciseSet)

    @objc(removeExerciseSetsObject:)
    @NSManaged public func removeFromExerciseSets(_ value: ExerciseSet)

    @objc(addExerciseSets:)
    @NSManaged public func addToExerciseSets(_ values: NSOrderedSet)

    @objc(removeExerciseSets:)
    @NSManaged public func removeFromExerciseSets(_ values: NSOrderedSet)

}

extension Exercise : Identifiable {

}
