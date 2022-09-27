//
//  ActiveWorkoutView.swift
//  Ironlog
//
//  Created by Brian Stauff on 3/26/22.
//

import SwiftUI

struct ActiveWorkoutView: View {
    @ObservedObject var workout: Workout
    private var repository: AppRepository
    init(workout: Workout, repository: AppRepository) {
        self.workout = workout
        self.repository = repository
    }
    var body: some View {
        List {
            ForEach($workout.exercises){$exercise in
                Section {
                    ActiveWorkoutExerciseView(workout: self.workout, exercise: exercise, repository: self.repository)
                }
            }
            HStack {
                Spacer()
                Toggle(isOn: $workout.isComplete) {
                    Text("Workout Complete")
                }.toggleStyle(.button)
                Spacer()
            }
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
        return ActiveWorkoutView(workout: workout, repository: workoutRepo)
    }
}
