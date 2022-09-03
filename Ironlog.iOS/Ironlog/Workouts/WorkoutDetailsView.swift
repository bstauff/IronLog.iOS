//
//  WorkoutView.swift
//  Ironlog
//
//  Created by Brian Stauff on 2/19/22.
//

import SwiftUI

struct WorkoutView: View {
    @ObservedObject var workout: Workout
    @State private var isSheetActive = false
    @State private var draftExercise: Exercise = Exercise()
    @State private var isShowingExerciseSheet = false
    
    var body: some View {
        VStack {
            List {
                Text(convertDateToString()).font(.largeTitle)
                HStack {
                    Text("Exercises").font(.headline)
                    Spacer()
                    Button(action: showExerciseSheet) {
                        Text("Add")
                    }.sheet(isPresented: $isShowingExerciseSheet){
                        WorkoutAddExerciseView(liftCatalog: self.liftCatalog, workout: self.workout)
                    }
                }
                ForEach($workout.exercises){ $exercise in
                    NavigationLink(
                        destination: EditExerciseView(exercise: exercise)) {
                            ExerciseRowView(exercise: exercise)
                        }
                }
                .onDelete { indexSet in
                    workout.exercises.remove(atOffsets: indexSet)
                }
            }
        }
    }
    
    func showExerciseSheet() {
        isShowingExerciseSheet = true
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
        
        return WorkoutView(workout: Workout(date: Date.now))
            .previewDevice("iPhone 13 Pro")
    }
}
