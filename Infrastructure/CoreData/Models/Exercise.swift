//
//  Exercise+CoreDataClass.swift
//  Ironlog
//
//  Created by Brian Stauff on 3/10/23.
//
//

import Foundation
import CoreData

@objc(Exercise)
public class Exercise: NSManagedObject {
    func planSetsForWeek(week: CycleWeek) {
        self.exerciseSets = []
    }
}
