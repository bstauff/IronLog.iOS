//
//  WorkoutView.swift
//  Ironlog
//
//  Created by Brian Stauff on 2/19/22.
//

import SwiftUI

struct WorkoutView: View {
    @ObservedObject var workout: Workout
    @ObservedObject var cycle: Cycle
    @ObservedObject var liftCatalog: LiftCatalog
    @State private var isSheetActive = false
    @State private var draftExercise: Exercise = Exercise()
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    Text("Exercises").font(.headline)
                    ForEach($workout.exercises){ $exercise in
                        NavigationLink(
                            destination: ExerciseView(liftCatalog: liftCatalog, exercise: exercise)) {
                                ExerciseRowView(exercise: exercise)
                            }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("add", action: addExercise)
                }
            }
            .navigationTitle(convertDateToString())
        }
    }
    
    func convertDateToString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY"
        return dateFormatter.string(from: self.workout.date)
    }
    
    func addExercise() {
        let newExercise = Exercise()
        workout.exercises.append(newExercise)
    }
}

struct ExerciseRowView: View {
    @ObservedObject var exercise: Exercise
    
    var body: some View {
        Text(exercise.lift.name)
    }
}

struct WorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        
        let liftCatalog = LiftCatalog()
        let squatLift = Lift(name: "Squat", trainingMax: 315)
        liftCatalog.lifts.append(squatLift)
        
        return WorkoutView(workout: Workout(date: Date.now), cycle: Cycle(), liftCatalog: liftCatalog)
            .previewDevice("iPhone 13 Pro")
    }
}
