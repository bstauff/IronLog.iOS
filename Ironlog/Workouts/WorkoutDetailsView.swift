//
//  WorkoutView.swift
//  Ironlog
//
//  Created by Brian Stauff on 2/19/22.
//

import SwiftUI

struct WorkoutDetailsView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @ObservedObject var workout: WorkoutModel
    
    @State private var isSheetActive = false
    @State private var isShowingExerciseSheet = false
    
    var exerciseArray: [ExerciseModel] {
        let exerciseSet = workout.workoutExercises as? Set<ExerciseModel> ?? []
        
        return exerciseSet.sorted {
            $0.exerciseLift?.name ?? "" < $1.exerciseLift?.name ?? ""
        }
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
                        AddExerciseView{newExercise in
                            self.workout.addToWorkoutExercises(newExercise)
                            try? self.viewContext.save()
                        }
                    }
                }
                ForEach(exerciseArray){ exercise in
                    NavigationLink(
                        destination: ExerciseDetailsView(exercise: exercise)) {
                            ExerciseRowView(exercise: exercise)
                        }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        let exerciseToDelete = exerciseArray[index]
                        workout.removeFromWorkoutExercises(exerciseToDelete)
                    }
                    try? self.viewContext.save()
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
}

struct ExerciseRowView: View {
    @ObservedObject var exercise: ExerciseModel
    
    var body: some View {
        Text(exercise.exerciseLift?.name ?? "")
    }
}

struct WorkoutDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        
        let appRepo = CoreDataRepository()
        let squatLift = Lift(name: "Squat", trainingMax: 315)
        let lifts = [squatLift]
        try? appRepo.addLift(lift: squatLift)
        let workout = Workout(date: Date())
        let squatExercise = Exercise()
        squatExercise.lift = squatLift
        workout.exercises = [squatExercise]
        
        return WorkoutDetailsView(repo: appRepo, workout: workout, lifts: .constant(lifts))
            .previewDevice("iPhone 13 Pro")
    }
}
