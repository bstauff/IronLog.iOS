//
//  WorkoutAddExerciseView.swift
//  Ironlog
//
//  Created by Brian Stauff on 4/23/22.
//

import SwiftUI

struct WorkoutAddExerciseView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var liftCatalog: LiftCatalog
    @ObservedObject var workout: Workout
    @State private var selectedLift: Lift?
    @State private var sets: [ExerciseSet] = []
    
    @State private var showingAddSetSheet = false
    
    @State private var isError = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationView{
            Form {
                Picker("Lift", selection: $selectedLift) {
                    ForEach($liftCatalog.lifts) { $lift in
                        Text(lift.name).tag(lift as Lift?)
                    }
                }
                Section {
                    HStack {
                        Text("Reps")
                        Spacer()
                        Text("Weight")
                    }
                    List {
                        ForEach($sets){ $exerciseSet in
                            HStack {
                                Text(String(exerciseSet.reps))
                                Spacer()
                                Text(String(exerciseSet.weight))
                            }
                        }
                        Button("Add Set") {
                            showingAddSetSheet = true
                        }.sheet(isPresented: $showingAddSetSheet) {
                            AddSetToExerciseSheet(exerciseSets: $sets)
                        }
                    }
                    
                }
                Section {
                    Button("Add Exercise") {
                        guard selectedLift != nil else {
                            isError = true
                            errorMessage = "Must select a lift"
                            return
                        }
                        
                        guard !sets.isEmpty else {
                            isError = true
                            errorMessage = "Must add sets"
                            return
                        }
                        
                        let newExercise = Exercise()
                        newExercise.sets = self.sets
                        newExercise.lift = self.selectedLift!
                        
                        workout.exercises.append(newExercise)
                        
                        presentationMode.wrappedValue.dismiss()
                        
                    }.buttonStyle(.borderedProminent)
                        .alert(isPresented: $isError) {
                            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                        }
                }
            }
        }
    }
}

struct WorkoutAddExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        let liftCatalog = LiftCatalog()
        let squatLift = Lift(name: "Squat", trainingMax: 315)
        liftCatalog.lifts.append(squatLift)
        
        let workout = Workout(date: Date.now)
        return WorkoutAddExerciseView(liftCatalog: liftCatalog, workout: workout)
    }
}
