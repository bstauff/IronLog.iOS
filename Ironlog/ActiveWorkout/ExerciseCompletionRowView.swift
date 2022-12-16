//
//  ActiveWorkoutExerciseView.swift
//  Ironlog
//
//  Created by Brian Stauff on 4/23/22.
//

import SwiftUI

struct ExerciseCompletionRowView: View {
    @ObservedObject var exercise: Exercise
    
    @ObservedObject var workout: Workout
    
    var body: some View {
        VStack {
            HStack {
                Text(exercise.lift.name).font(.headline)
                Spacer()
                Text("reps")
                Spacer()
                Text("weight")
            }
            ForEach($exercise.sets){ $exerciseset in
                HStack {
                    Toggle(isOn: $exerciseset.isComplete) {
                       Text("done")
                    }
                        .toggleStyle(.button)
                        .onChange(of: exerciseset.isComplete) { value in
                        }
                    Spacer()
                    Text(String(exerciseset.reps))
                    Spacer()
                    Text(String(exerciseset.weight))
                }
            }
        }
    }
}

struct ExerciseCompletionRowView_Previews: PreviewProvider {
    static var previews: some View {
        let squatMain = Exercise()
        let squatLift = Lift(
            name: "squat",
            trainingMax: 315
        )

        let workoutA = Workout(date: Date())
        
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
        return ExerciseCompletionRowView(exercise: squatMain, workout: workoutA)
    }
}
