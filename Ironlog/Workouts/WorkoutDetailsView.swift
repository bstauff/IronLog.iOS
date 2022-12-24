//
//  WorkoutView.swift
//  Ironlog
//
//  Created by Brian Stauff on 2/19/22.
//

import SwiftUI

struct WorkoutDetailsView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @ObservedObject var workout: Workout
    
    @State private var isSheetActive = false
    @State private var isShowingExerciseSheet = false
    
    @State private var isShowingEditSheet = false
    
    var exerciseArray: [Exercise] {
        return workout.warmupExercises?.array as? [Exercise] ?? []
    }
    
    var body: some View {
        VStack {
            List {
                HStack {
                    Text("Exercises").font(.headline)
                    Spacer()
                    Button(action: showExerciseSheet) {
                        Image(systemName: "plus.circle.fill").foregroundColor(.blue)
                    }
                    .sheet(isPresented: $isShowingExerciseSheet){
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
        .sheet(isPresented: $isShowingEditSheet) {
            EditWorkoutView(workout: workout)
        }
        .navigationTitle(Text(convertDateToString()))
        .toolbar {
            ToolbarItem(placement:.navigationBarTrailing) {
                Button("Edit") {
                    self.isShowingEditSheet = true
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
    @ObservedObject var exercise: Exercise
    
    var body: some View {
        Text(exercise.exerciseLift?.name ?? "")
    }
}

struct WorkoutDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let stuff = WorkoutModel.fetchRequest()
        
        let moreStuff = try? viewContext.fetch(stuff)
        
        return NavigationView {
            WorkoutDetailsView(workout: (moreStuff?.first!)!)
        }
            .environment(\.managedObjectContext, viewContext)
    }
}
