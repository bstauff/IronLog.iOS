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
    
    var warmupExercises: [WarmupExercise] {
        return workout.warmupExercises?.array as? [WarmupExercise] ?? []
    }
    
    var assistanceExercises: [AssistanceExercise] {
        return workout.assistanceExercises?.array as? [AssistanceExercise] ?? []
    }
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Warmup Lifts")) {
                    if warmupExercises.count > 0 {
                        ForEach(warmupExercises){ warmupExercise in
                            NavigationLink(
                                destination: ExerciseDetailsView(exercise: warmupExercise)) {
                                ExerciseRowView(exercise: warmupExercise)
                            }
                        }
                    } else {
                        Text("Go add some warmup work!")
                    }
                }
                Section(header: Text("Main Lift")) {
                    if self.workout.mainExercise != nil {
                        NavigationLink(
                            destination: ExerciseDetailsView(exercise: self.workout.mainExercise!)) {
                            ExerciseRowView(exercise: self.workout.mainExercise!)
                        }
                    } else {
                        Text("Go add some main work!")
                    }
                }
                Section(header: Text("Supplemental Lift")) {
                    if self.workout.supplementalExercise != nil {
                        NavigationLink(
                            destination: ExerciseDetailsView(exercise: self.workout.supplementalExercise!)) {
                            ExerciseRowView(exercise: self.workout.supplementalExercise!)
                        }
                    } else {
                        Text("Go add some supplemental work!")
                    }
                }
                Section(header: Text("Assistance Lifts")) {
                    if assistanceExercises.count > 0 {
                        ForEach(assistanceExercises){ assistanceExercise in
                            NavigationLink(
                                destination: ExerciseDetailsView(exercise: assistanceExercise)) {
                                ExerciseRowView(exercise: assistanceExercise)
                            }
                        }
                    } else {
                        Text("Go add some assistance work!")
                    }
                }
            }
            .listStyle(.insetGrouped)
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
        Text(exercise.lift?.name ?? "")
    }
}

struct WorkoutDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let stuff = Workout.fetchRequest()

        let moreStuff = try? viewContext.fetch(stuff)

        return NavigationView {
            WorkoutDetailsView(workout: (moreStuff?.first!)!)
        }
            .environment(\.managedObjectContext, viewContext)
    }
}
