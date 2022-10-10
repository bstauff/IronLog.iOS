//
//  WorkoutSelection.swift
//  Ironlog
//
//  Created by Brian Stauff on 10/7/22.
//

import SwiftUI

struct WorkoutSelection: View {
    @Binding var workouts: [Workout]
    @Binding var selectedWorkout: Workout?
    var body: some View {
        Picker("Workout", selection: $selectedWorkout) {
            ForEach($workouts, id: \.self) { $workout in
                Text(getWorkoutDate(workout: workout)).tag(workout as Workout?)
            }
        }
    }
    func getWorkoutDate(workout: Workout) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY"
        return dateFormatter.string(from: workout.date)
    }
}

struct WorkoutSelection_Previews: PreviewProvider {
    static var previews: some View {
        var selectedWorkout: Workout = Workout(date: Date())
        WorkoutSelection(workouts: .constant([Workout(date: Date())]), selectedWorkout: .constant(selectedWorkout))
    }
}
