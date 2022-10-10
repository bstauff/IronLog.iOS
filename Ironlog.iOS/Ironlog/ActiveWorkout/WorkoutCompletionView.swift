//
//  WorkoutCompletionView.swift
//  Ironlog
//
//  Created by Brian Stauff on 10/6/22.
//

import SwiftUI

struct WorkoutCompletionView: View {
    @ObservedObject var workout: Workout
    private var appRepository: AppRepository
    
    init(workout: Workout, appRepository: AppRepository) {
        self.workout = workout
        self.appRepository = appRepository
    }
    var body: some View {
        HStack {
            Spacer()
            Toggle(isOn: $workout.isComplete) {
                Text("Workout Complete")
            }
                .toggleStyle(.button)
                .onChange(of: workout.isComplete) { value in
                    try? appRepository.saveWorkout(workout: self.workout)
                }
            Spacer()
        }
    }
}

struct WorkoutCompletionView_Previews: PreviewProvider {
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
        return WorkoutCompletionView(workout: workout, appRepository: workoutRepo)
    }
}
