//
//  WorkoutAddExerciseView.swift
//  Ironlog
//
//  Created by Brian Stauff on 4/23/22.
//

import SwiftUI

struct AddExerciseView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var workout: Workout
    @State private var selectedLift: Lift?
    @State private var sets: [ExerciseSet] = []
    
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
                Form {
                    LiftSelectionView(lifts: lifts)
                    Section {
                        EditSetsView(updatedSets: $sets)
                    }
                    Section {
                        HStack {
                            Spacer()
                            Button("Save") {
                                createNewExercise()
                                presentationMode.wrappedValue.dismiss()
                            }
                                .buttonStyle(.borderedProminent)
                                .alert(isPresented: $isError) {
                                    Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                                }
                            Spacer()
                        }
                    }
                }
            }
        }
    }
        
    func createNewExercise() -> Void {
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
    }
}

struct AddExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        let appRepo = CoreDataRepository()
        let squatLift = Lift(name: "Squat", trainingMax: 315)
        let lifts = [squatLift, Lift(name: "Bench", trainingMax: 300)]
        try? appRepo.addLift(lift: squatLift)
        
        
        let workout = Workout(date: Date.now)
        return AddExerciseView(repo: appRepo, workout: workout, lifts: .constant(lifts))
    }
}
