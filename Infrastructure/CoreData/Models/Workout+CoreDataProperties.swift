//
//  Workout+CoreDataProperties.swift
//  Ironlog
//
//  Created by Brian Stauff on 3/10/23.
//
//

import Foundation
import CoreData


extension Workout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout")
    }

    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var isComplete: Bool
    @NSManaged public var assistanceExercises: NSOrderedSet?
    @NSManaged public var mainExercise: MainExercise?
    @NSManaged public var supplementalExercise: SupplementalExercise?
    @NSManaged public var warmupExercises: NSOrderedSet?

}

// MARK: Generated accessors for assistanceExercises
extension Workout {

    @objc(insertObject:inAssistanceExercisesAtIndex:)
    @NSManaged public func insertIntoAssistanceExercises(_ value: AssistanceExercise, at idx: Int)

    @objc(removeObjectFromAssistanceExercisesAtIndex:)
    @NSManaged public func removeFromAssistanceExercises(at idx: Int)

    @objc(insertAssistanceExercises:atIndexes:)
    @NSManaged public func insertIntoAssistanceExercises(_ values: [AssistanceExercise], at indexes: NSIndexSet)

    @objc(removeAssistanceExercisesAtIndexes:)
    @NSManaged public func removeFromAssistanceExercises(at indexes: NSIndexSet)

    @objc(replaceObjectInAssistanceExercisesAtIndex:withObject:)
    @NSManaged public func replaceAssistanceExercises(at idx: Int, with value: AssistanceExercise)

    @objc(replaceAssistanceExercisesAtIndexes:withAssistanceExercises:)
    @NSManaged public func replaceAssistanceExercises(at indexes: NSIndexSet, with values: [AssistanceExercise])

    @objc(addAssistanceExercisesObject:)
    @NSManaged public func addToAssistanceExercises(_ value: AssistanceExercise)

    @objc(removeAssistanceExercisesObject:)
    @NSManaged public func removeFromAssistanceExercises(_ value: AssistanceExercise)

    @objc(addAssistanceExercises:)
    @NSManaged public func addToAssistanceExercises(_ values: NSOrderedSet)

    @objc(removeAssistanceExercises:)
    @NSManaged public func removeFromAssistanceExercises(_ values: NSOrderedSet)

}

// MARK: Generated accessors for warmupExercises
extension Workout {

    @objc(insertObject:inWarmupExercisesAtIndex:)
    @NSManaged public func insertIntoWarmupExercises(_ value: WarmupExercise, at idx: Int)

    @objc(removeObjectFromWarmupExercisesAtIndex:)
    @NSManaged public func removeFromWarmupExercises(at idx: Int)

    @objc(insertWarmupExercises:atIndexes:)
    @NSManaged public func insertIntoWarmupExercises(_ values: [WarmupExercise], at indexes: NSIndexSet)

    @objc(removeWarmupExercisesAtIndexes:)
    @NSManaged public func removeFromWarmupExercises(at indexes: NSIndexSet)

    @objc(replaceObjectInWarmupExercisesAtIndex:withObject:)
    @NSManaged public func replaceWarmupExercises(at idx: Int, with value: WarmupExercise)

    @objc(replaceWarmupExercisesAtIndexes:withWarmupExercises:)
    @NSManaged public func replaceWarmupExercises(at indexes: NSIndexSet, with values: [WarmupExercise])

    @objc(addWarmupExercisesObject:)
    @NSManaged public func addToWarmupExercises(_ value: WarmupExercise)

    @objc(removeWarmupExercisesObject:)
    @NSManaged public func removeFromWarmupExercises(_ value: WarmupExercise)

    @objc(addWarmupExercises:)
    @NSManaged public func addToWarmupExercises(_ values: NSOrderedSet)

    @objc(removeWarmupExercises:)
    @NSManaged public func removeFromWarmupExercises(_ values: NSOrderedSet)

}

extension Workout : Identifiable {

}
