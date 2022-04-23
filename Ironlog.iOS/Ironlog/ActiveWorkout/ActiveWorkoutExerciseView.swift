//
//  ActiveWorkoutExerciseView.swift
//  Ironlog
//
//  Created by Brian Stauff on 4/23/22.
//

import SwiftUI

struct ActiveWorkoutExerciseView: View {
    @ObservedObject var exercise: Exercise
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
                    }.toggleStyle(.button)
                    Spacer()
                    Text(String(exerciseset.reps))
                    Spacer()
                    Text(String(exerciseset.weight))
                }
            }
        }
    }
}

struct ActiveWorkoutExerciseView_Previews: PreviewProvider {
    static var previews: some View {
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
        return ActiveWorkoutExerciseView(exercise: squatMain)
    }
}
