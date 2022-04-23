//
//  NewExerciseView.swift
//  Ironlog
//
//  Created by Brian Stauff on 2/21/22.
//

import SwiftUI

struct ExerciseView: View {
    @ObservedObject var liftCatalog: LiftCatalog
    @ObservedObject var exercise: Exercise
    @State private var showingSheet = false
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Lift", selection: $exercise.lift) {
                    ForEach($liftCatalog.lifts) { $lift in
                        Text(lift.name).tag(lift)
                    }
                }
                Section {
                    HStack {
                        Text("Reps")
                        Spacer()
                        Text("Weight")
                    }
                    List {
                        ForEach($exercise.sets) {$exerciseSet in
                            HStack {
                                Text(String(exerciseSet.reps))
                                Spacer()
                                Text(String(exerciseSet.weight))
                            }
                        }
                        Button("Add Set") {
                            showingSheet = true
                        }
                        .sheet(isPresented: $showingSheet) {
                            AddExerciseSetSheet(isShowing: $showingSheet, exerciseSets: $exercise.sets)
                        }
                    }
                }
            }
        }
    }
}

struct AddExerciseSetSheet: View {
    @Binding var isShowing: Bool
    @Binding var exerciseSets: [ExerciseSet]
    @State private var reps = 0
    @State private var weight = 0
    @State private var isShowingAlert = false
    var body: some View {
        VStack{
            Text("Reps")
            TextField("Reps", value: $reps, format: .number)
            Text("Weight")
            TextField("Weight", value: $weight, format: .number)
        }
        Button("add") {
            if reps == 0 || weight == 0 {
                isShowingAlert = true
                return
            } else {
                let newExercise = ExerciseSet(reps: self.reps, weight: self.weight)
                exerciseSets.append(newExercise)
                isShowing = false
            }
        }
        .alert("Both reps and weight are required", isPresented: $isShowingAlert) {
            
        }
        Button("cancel") {
            isShowing = false
        }
    }
}


struct ExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        let liftCatalog = LiftCatalog()
        let squatLift = Lift(name: "Squat", trainingMax: 315)
        liftCatalog.lifts.append(squatLift)
        liftCatalog.lifts.append(Lift(name: "Bench", trainingMax: 250))
            
        let exercise = Exercise()
        exercise.lift = squatLift
        
        return ExerciseView(liftCatalog: liftCatalog, exercise: exercise)
    }
}
