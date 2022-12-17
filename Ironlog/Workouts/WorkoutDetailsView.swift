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
        return workout.workoutExercises?.array as? [ExerciseModel] ?? []
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
                        self.viewContext.delete(exerciseToDelete)
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
        return dateFormatter.string(from: self.workout.date!)
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
        let viewContext = PersistenceController.preview.container.viewContext
        let stuff = WorkoutModel.fetchRequest()
        
        let moreStuff = try? viewContext.fetch(stuff)
        
        return WorkoutDetailsView(workout: (moreStuff?.first!)!)
            .environment(\.managedObjectContext, viewContext)
    }
}
