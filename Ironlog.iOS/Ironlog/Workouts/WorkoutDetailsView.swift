//
//  WorkoutView.swift
//  Ironlog
//
//  Created by Brian Stauff on 2/19/22.
//

import SwiftUI

struct WorkoutDetailsView: View {
    @ObservedObject var workout: Workout
    @State private var isSheetActive = false
    @State private var draftExercise: Exercise = Exercise()
    @State private var isShowingExerciseSheet = false
    
    private var lifts: [Lift] = []
    
    var repo: AppRepository
    
    init(repo: AppRepository, workout: Workout) {
        self.repo = repo
        self.workout = workout
    }
    
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
                        WorkoutAddExerciseView(repo: repo, workout: workout)
                    }
                }
                ForEach($workout.exercises){ $exercise in
                    NavigationLink(
                        destination: EditExerciseView(repo: repo, exercise: exercise)) {
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

struct WorkoutDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        
        let appRepo = CoreDataRepository()
        let squatLift = Lift(name: "Squat", trainingMax: 315)
        try? appRepo.addLift(lift: squatLift)
        
        return WorkoutDetailsView(repo: appRepo, workout: Workout(date: Date.now))
            .previewDevice("iPhone 13 Pro")
    }
}
