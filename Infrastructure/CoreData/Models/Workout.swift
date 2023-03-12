//
//  Workout+CoreDataClass.swift
//  Ironlog
//
//  Created by Brian Stauff on 3/10/23.
//
//

import Foundation
import CoreData

@objc(Workout)
public class Workout: NSManagedObject {
    public override init(entity: NSEntityDescription, insertInto context: NSManagedObjectContext?) {
        super.init(entity: entity, insertInto: context)
        self.id = UUID()
        self.date = Date().timeIntervalSince1970
        self.isComplete = false
    }
    
    func planForWeek(lift: Lift, week: CycleWeek) {
        let warmup = planWarmupExercise(warmupLift: lift, cycleWeek: week)
        self.addToWarmupExercises(warmup)
        
        let main = planMainExercise(mainLift: lift, cycleWeek: week)
        self.mainExercise = main
        
        let supplemental = planSupplementalExercise(supplementalLift: lift, cycleWeek: week)
        self.supplementalExercise = supplemental
    }
    
    func planAssistance(assistanceLift: Lift) {
        let assistanceExercise = AssistanceExercise(context: self.managedObjectContext!)
        assistanceExercise.lift = assistanceLift
        assistanceExercise.planSetsForWeek(week: CycleWeek.firstWeek)
        self.addToAssistanceExercises(assistanceExercise)
    }
    
    private func planWarmupExercise(warmupLift: Lift, cycleWeek: CycleWeek) -> WarmupExercise {
        let warmupExercise = WarmupExercise(context: self.managedObjectContext!)
        warmupExercise.lift = warmupLift
        warmupExercise.planSetsForWeek(week: cycleWeek)
        return warmupExercise
    }
    
    private func planMainExercise(mainLift: Lift, cycleWeek: CycleWeek) -> MainExercise {
        let mainExercise = MainExercise(context: self.managedObjectContext!)
        mainExercise.lift = mainLift
        mainExercise.planSetsForWeek(week: cycleWeek)
        return mainExercise
    }
    
    private func planSupplementalExercise(supplementalLift: Lift, cycleWeek: CycleWeek) -> SupplementalExercise {
        let supplementalExercise = SupplementalExercise(context: self.managedObjectContext!)
        supplementalExercise.lift = supplementalLift
        supplementalExercise.planSetsForWeek(week: cycleWeek)
        return supplementalExercise
    }
}
