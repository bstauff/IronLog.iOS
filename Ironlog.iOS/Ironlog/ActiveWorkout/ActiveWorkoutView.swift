//
//  ActiveWorkoutView.swift
//  Ironlog
//
//  Created by Brian Stauff on 3/26/22.
//

import SwiftUI

struct ActiveWorkoutView: View {
    @State private var isError = false
    @State private var errorMessage = ""
    
    @State private var selectedWorkout: Workout? = nil
    
    private var repository: AppRepository
    
    init(repository: AppRepository) {
        self.repository = repository
    }
    
    var body: some View {
        List {
            ExerciseCompletionView(repository: repository, workout: selectedWorkout!)
            HStack {
                Spacer()
                Toggle(isOn: $workout.isComplete) {
                    Text("Workout Complete")
                }.toggleStyle(.button)
                Spacer()
            }
            HStack {
                Spacer()
                Button("Save") {
                    do {
                        try self.repository.saveWorkout(workout: workout)
                    } catch {
                        self.isError = true
                        self.errorMessage = "Failed to save exercise"
                        return
                    }
                }
                Spacer()
            }
        }
        .alert(isPresented: $isError) {
            Alert(
                title: Text("oops"),
                message: Text("Failed to save workout"),
                dismissButton: .default(Text("OK")))
        }
    }
}

struct ActiveWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        let workout = Workout(date: Date())
        let squatMain = Exercise()
        let squatLift = Lift(
            name: "squat",
            trainingMax: 315
        )

        squatMain.lift = squatLift
        squatMain.sets.append(
            ExerciseSet(reps: 5, weight: 250)
        )
        squatMain.sets.append(
            ExerciseSet(reps: 3, weight: 275)
        )
        squatMain.sets.append(
            ExerciseSet(reps: 1, weight: 300)
        )
        
        workout.exercises.append(squatMain)
        
        let squatSupplemental = Exercise()
        squatSupplemental.sets.append(
            ExerciseSet(reps: 5, weight: 250)
        )
        squatSupplemental.sets.append(
            ExerciseSet(reps: 5, weight: 250)
        )
        squatSupplemental.sets.append(
            ExerciseSet(reps: 5, weight: 250)
        )
        squatSupplemental.sets.append(
            ExerciseSet(reps: 5, weight: 250)
        )
        squatSupplemental.sets.append(
            ExerciseSet(reps: 5, weight: 250)
        )
        squatSupplemental.lift = squatLift
        
        workout.exercises.append(squatSupplemental)
        
        
        let workoutRepo = CoreDataRepository()
        return ActiveWorkoutView(repository: workoutRepo, workout: workout)
    }
}
