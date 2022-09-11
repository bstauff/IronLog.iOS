//
//  WorkoutAddExerciseView.swift
//  Ironlog
//
//  Created by Brian Stauff on 4/23/22.
//

import SwiftUI

struct WorkoutAddExerciseView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var workout: Workout
    @State private var selectedLift: Lift?
    @State private var sets: [ExerciseSet] = []
    
    @State private var shouldNavigate = false
    
    @State private var isError = false
    @State private var errorMessage = ""
    
    @Binding private var lifts: [Lift]
    
    private var repo: AppRepository
    
    init(repo: AppRepository, workout: Workout, lifts: Binding<[Lift]>) {
        self.workout = workout
        self.repo = repo
        self._lifts = lifts
    }
    
    var body: some View {
        NavigationView{
            VStack {
                NavigationLink(
                    destination:AddSetToExerciseSheet(exerciseSets: $sets),
                    isActive: $shouldNavigate) {
                        EmptyView()
                    }
                Form {
                    Picker("Lift", selection: $selectedLift) {
                        ForEach($lifts) { $lift in
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
                                shouldNavigate = true
                            }
                        }
                        
                    }
                    Section {
                        Button("Save") {
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
                            
                            do {
                                try self.repo.saveWorkout(workout: workout)
                            } catch {
                                self.isError = true
                                self.errorMessage = "Failed to save exercise"
                                workout.exercises.removeLast()
                                return
                            }
                            
                            
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
}

struct WorkoutAddExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        let appRepo = CoreDataRepository()
        let squatLift = Lift(name: "Squat", trainingMax: 315)
        let lifts = [squatLift]
        try? appRepo.addLift(lift: squatLift)
        
        
        let workout = Workout(date: Date.now)
        return WorkoutAddExerciseView(repo: appRepo, workout: workout, lifts: .constant(lifts))
    }
}
