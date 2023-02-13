//
//  AddCycleWorkoutView.swift
//  Ironlog
//
//  Created by Brian Stauff on 4/23/22.
//

import SwiftUI

struct AddWorkoutView: View {
    @Environment(\.managedObjectContext) var viewContext
    @Environment(\.presentationMode) var presentationMode
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var lifts: FetchedResults<Lift>
    
    @State private var selectedDate = Date()
    @State private var selectedLift: Lift? = nil
    
    @State private var isError = false
    @State private var errorString = ""
    @State private var selectedCycleWeek = 1
    
    private var newWorkout: FslAmrapWorkout
    
    init() {
        newWorkout = FslAmrapWorkout()
    }
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    DatePicker("Workout Date", selection: $selectedDate, displayedComponents: .date)
                }
                Section {
                    Picker("Cycle Week", selection: $selectedCycleWeek) {
                        ForEach((1..<4)) { week in
                            Text(String(week)).tag(week)
                        }
                    }
                }
                Section {
                    Picker("Main Lift", selection: $selectedLift) {
                        ForEach(lifts) { lift in
                            Text(lift.name ?? "").tag(lift as Lift?)
                        }
                    }
                }
                Section {
                    HStack {
                        Spacer()
                        Button("Create") {
                            saveClicked()
                        }
                        .buttonStyle(.borderedProminent)
                        .alert(isPresented: $isError) {
                            Alert(title: Text("Error"), message: Text(errorString), dismissButton: .default(Text("OK")))
                        }
                        Spacer()
                    }
                }
            }.navigationTitle("Add Workout")
        }
    }
    
    func saveClicked() {
        let newWorkout = FslAmrapWorkout(context: viewContext)
        newWorkout.id = UUID()
        newWorkout.isComplete = false
        newWorkout.date = selectedDate
        
        newWorkout.warmupExercises = NSOrderedSet(array: [buildWarmupWork()])
        newWorkout.mainExercise = buildMainWork()
        
        do {
            try viewContext.save()
        } catch {
            isError = true
            errorString = "Failed to add new workout"
            return
        }
        presentationMode.wrappedValue.dismiss()
    }
    
    private func buildWarmupWork() -> WarmupExercise {
        let newWarmup = WarmupExercise(context: self.viewContext)
        newWarmup.id = UUID()
        newWarmup.isComplete = false
        newWarmup.lift = self.selectedLift
        
        let set1 = ExerciseSet(context: self.viewContext)
        set1.isComplete = false
        set1.id = UUID()
        set1.reps = 5
        set1.weight = Int32(getTrainingMaxWeight(lift: self.selectedLift!, multiplier: 0.4))
        
        let set2 = ExerciseSet(context: self.viewContext)
        set2.isComplete = false
        set2.id = UUID()
        set2.reps = 5
        set2.weight = Int32(getTrainingMaxWeight(lift: self.selectedLift!, multiplier: 0.5))
        
        let set3 = ExerciseSet(context: self.viewContext)
        set3.isComplete = false
        set3.id = UUID()
        set3.reps = 3
        set3.weight = Int32(getTrainingMaxWeight(lift: self.selectedLift!, multiplier: 0.6))
        
        let sets = NSOrderedSet(array: [
            set1,
            set2,
            set3
        ])
        
        newWarmup.exerciseSets = sets
        
        return newWarmup
    }
    
    private func getTrainingMaxWeight(lift: Lift, multiplier: Double) -> Int {
        let liftTrainingMax = Double(lift.trainingMax)
        
        let scaledWeight = (liftTrainingMax * multiplier) / 5
        
        let scaledWeightRounded = 5 * scaledWeight.rounded(.toNearestOrAwayFromZero)
        
        return Int(scaledWeightRounded)
        
    }
    
    private func buildMainWork() -> MainExercise {
        let newMainExercise = MainExercise(context: self.viewContext)
        newMainExercise.id = UUID()
        newMainExercise.isComplete = false
        newMainExercise.lift = self.selectedLift
        
        var set1Reps: Int32 = 5
        var set1Multiplier: Double = 0.65
        var set2Reps: Int32 = 5
        var set2Multiplier: Double = 0.75
        var set3Reps: Int32 = 5
        var set3Multiplier: Double = 0.85
        
        if self.selectedCycleWeek == 2 {
            set1Reps = 3
            set1Multiplier = 0.70
            set2Reps = 3
            set2Multiplier =  0.80
            set3Reps = 3
            set3Multiplier = 0.90
        }
        
        if self.selectedCycleWeek == 3 {
            set1Multiplier = 0.75
            set2Reps = 3
            set2Multiplier = 0.85
            set3Reps = 1
            set3Multiplier = 0.95
        }
        
        let set1 = ExerciseSet(context: self.viewContext)
        set1.isComplete = false
        set1.id = UUID()
        set1.reps = set1Reps
        set1.weight = Int32(getTrainingMaxWeight(lift: self.selectedLift!, multiplier: set1Multiplier))
        
        let set2 = ExerciseSet(context: self.viewContext)
        set2.isComplete = false
        set2.id = UUID()
        set2.reps = set2Reps
        set2.weight = Int32(getTrainingMaxWeight(lift: self.selectedLift!, multiplier: set2Multiplier))
        
        let set3 = ExerciseSet(context: self.viewContext)
        set3.isComplete = false
        set3.id = UUID()
        set3.reps = set3Reps
        set3.weight = Int32(getTrainingMaxWeight(lift: self.selectedLift!, multiplier: set3Multiplier))
        
        let sets = NSOrderedSet(array: [
            set1,
            set2,
            set3
        ])
        
        newMainExercise.exerciseSets = sets
        
        return newMainExercise
    }
}

struct AddWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        AddWorkoutView()
            .environment(\.managedObjectContext, viewContext)
    }
}
