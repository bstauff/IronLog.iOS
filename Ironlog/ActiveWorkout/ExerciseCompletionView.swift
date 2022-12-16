//
//  ExerciseCompletionVIew.swift
//  Ironlog
//
//  Created by Brian Stauff on 10/3/22.
//

import SwiftUI

struct ExerciseCompletionView: View {
    @ObservedObject var workout: Workout
    
    var body: some View {
        ForEach($workout.exercises){$exercise in
            Section {
                ExerciseCompletionRowView(
                    exercise: exercise,
                    workout: self.workout)
            }
        }
    }
}

struct ExerciseCompletionView_Previews: PreviewProvider {
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
        
        return ExerciseCompletionRowView(exercise: squatMain, workout: workout)
    }
}
