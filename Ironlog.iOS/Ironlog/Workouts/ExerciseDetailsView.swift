//
//  EditExerciseView.swift
//  Ironlog
//
//  Created by Brian Stauff on 4/30/22.
//

import SwiftUI

struct ExerciseDetailsView: View {
    @State private var isError = false
    @State private var errorMessage = ""
    
    @State private var shouldShowEditSheet = false
    
    @Binding private var lifts: [Lift]
    
    private var repo: AppRepository
    
    @ObservedObject var exercise: Exercise
    
    init(repo: AppRepository, exercise: Exercise, lifts: Binding<[Lift]>) {
        self.repo = repo
        self.exercise = exercise
        self._lifts = lifts
    }
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Sets")) {
                    HStack {
                        Text("Reps")
                        Spacer()
                        Text("Weight")
                    }
                    List {
                        ForEach($exercise.sets){ $exerciseSet in
                            HStack {
                                Text(String(exerciseSet.reps))
                                Spacer()
                                Text(String(exerciseSet.weight))
                            }
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $shouldShowEditSheet) {
            NavigationView {
                EditExerciseView(
                    repo: self.repo,
                    exercise: exercise,
                    lifts: $lifts,
                    updatedLift: $exercise.lift,
                    updatedSets: $exercise.sets
                )
                .navigationTitle(exercise.lift.name)
                .toolbar {
                    ToolbarItem(placement: .cancellationAction) {
                        Button("Cancel") {
                            shouldShowEditSheet = false
                        }
                    }
                }
            }
        }
        .navigationTitle(exercise.lift.name)
        .toolbar {
            Button("Edit") {
                self.shouldShowEditSheet = true
            }
        }
    }
    
    private func loadLifts() {
        do {
            let lifts = try repo.getAllLifts()
            self.lifts = lifts
        } catch {
            isError = true
            errorMessage = "Failed to load lifts"
        }
    }
}

struct ExerciseDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let liftRepo = CoreDataRepository()
        let squat = Lift(name: "Squat", trainingMax: 315)
        let lifts = [squat]
        let sets = [
            ExerciseSet(reps: 5, weight: 250)
        ]
        let exercise = Exercise(id: UUID(), sets: sets, lift: squat, isComplete: false)
        return NavigationView {
            ExerciseDetailsView(repo: liftRepo, exercise: exercise, lifts: .constant(lifts))
        }
    }
}
