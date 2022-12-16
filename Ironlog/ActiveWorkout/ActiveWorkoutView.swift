//
//  ActiveWorkoutView.swift
//  Ironlog
//
//  Created by Brian Stauff on 3/26/22.
//

import SwiftUI

struct ActiveWorkoutView: View {
    @Binding var workouts: [Workout]
    
    @State private var isError = false
    @State private var errorMessage = ""
    @State private var selectedWorkout: Workout? = nil
    
    var body: some View {
        NavigationView {
            List {
                WorkoutSelection(workouts: $workouts, selectedWorkout: $selectedWorkout)
                if(selectedWorkout != nil) {
                    ExerciseCompletionView(workout: selectedWorkout!)
                    WorkoutCompletionView(workout: selectedWorkout!)
                } else {
                    Text("No workout selected")
                }
            }
        }
        .alert(isPresented: $isError) {
            Alert(
                title: Text("oops"),
                message: Text("Failed to save workout"),
                dismissButton: .default(Text("OK")))
        }
    }
    
    func getWorkoutDate(workout: Workout) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY"
        return dateFormatter.string(from: workout.date)
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
        
        return ActiveWorkoutView(workouts: .constant([workout]))
    }
}
