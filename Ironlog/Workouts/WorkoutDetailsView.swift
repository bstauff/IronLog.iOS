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
    @State private var isShowingAddWarmUpSheet = false
    @State private var isShowingAddAssistanceSheet = false
    @State private var isShowingAddMainSheet = false
    @State private var isShowingAddSupplementalSheet = false
    
    @State private var isError = false
    @State private var errorMessage = ""
    
    var warmupExercises: [WarmupExercise] {
        return workout.warmupExercises?.array as? [WarmupExercise] ?? []
    }
    
    var assistanceExercises: [AssistanceExercise] {
        return workout.assistanceExercises?.array as? [AssistanceExercise] ?? []
    }
    
    var body: some View {
        VStack {
            List {
                Section(
                    header: ExerciseHeaderView(canAdd: .constant(true), headerTitle: "Warm Up Lifts"){
                        self.isShowingAddWarmUpSheet = true
                    }) {
                        if warmupExercises.count > 0 {
                            ForEach(warmupExercises){ warmupExercise in
                                NavigationLink(
                                    destination: ExerciseDetailsView(exercise: warmupExercise)) {
                                    ExerciseRowView(exercise: warmupExercise)
                                }
                            }
                            .onDelete(perform: deleteWarmups)
                        } else {
                            Text("Go add some warmup work!")
                        }
                    }
                Section(
                    header: MainHeaderView(workout: self.workout, headerTitle: "Main Lift") {
                        self.isShowingAddMainSheet = true
                    }) {
                        if self.workout.mainExercise != nil {
                            NavigationLink(
                                destination: ExerciseDetailsView(exercise: self.workout.mainExercise!)) {
                                ExerciseRowView(exercise: self.workout.mainExercise!)
                            }
                        } else {
                            Text("Go add some main work!")
                        }
                    }
                Section(
                    header: SupplementalHeaderView(workout: self.workout, headerTitle: "Supplemental Lift") {
                        self.isShowingAddSupplementalSheet = true
                    }) {
                        if self.workout.supplementalExercise != nil {
                            NavigationLink(
                                destination: ExerciseDetailsView(exercise: self.workout.supplementalExercise!)) {
                                ExerciseRowView(exercise: self.workout.supplementalExercise!)
                            }
                        } else {
                            Text("Go add some supplemental work!")
                        }
                    }
                Section(header: ExerciseHeaderView(canAdd: .constant(true), headerTitle: "Assistance Lifts") {
                    self.isShowingAddAssistanceSheet = true
                }) {
                    if assistanceExercises.count > 0 {
                        ForEach(assistanceExercises){ assistanceExercise in
                            NavigationLink(
                                destination: ExerciseDetailsView(exercise: assistanceExercise)) {
                                ExerciseRowView(exercise: assistanceExercise)
                            }
                        }
                        .onDelete(perform: deleteAssistance)
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
        .sheet(isPresented: $isShowingAddWarmUpSheet) {
            AddWarmUpView(workout: workout)
        }
        .sheet(isPresented: $isShowingAddAssistanceSheet) {
            AddAssistanceView(workout: workout)
        }
        .sheet(isPresented: $isShowingAddMainSheet) {
            AddMainView(workout: workout)
        }
        .sheet(isPresented: $isShowingAddSupplementalSheet) {
            AddSupplementalView(workout: workout)
        }
        .alert(isPresented: $isError) {
            Alert(
                title: Text("Error"),
                message: Text(self.errorMessage),
                dismissButton: .default(Text("OK"))
            )
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
    
    func deleteWarmups(indexSet: IndexSet) {
        for index in indexSet {
            let warmup = warmupExercises[index]
            workout.removeFromWarmupExercises(warmup)
            self.viewContext.delete(warmup)
        }
        
        do {
            try self.viewContext.save()
        } catch {
            self.isError = true
            self.errorMessage = "\(error)"
            return
        }
    }
    
    func deleteAssistance(indexSet: IndexSet) {
        for index in indexSet {
            let assistance = assistanceExercises[index]
            workout.removeFromAssistanceExercises(assistance)
            self.viewContext.delete(assistance)
        }
        
        do {
            try self.viewContext.save()
        } catch {
            self.isError = true
            self.errorMessage = "\(error)"
            return
        }
    }
}

struct ExerciseHeaderView: View {
    @Binding var canAdd: Bool
    
    var headerTitle: String
    
    var onAddClicked: () -> Void
    
    var body: some View {
        HStack {
            Text(headerTitle)
            Spacer()
            Button(action: onAddClicked) {
                Image(systemName: "plus.circle.fill")
            }
        }
    }
}

struct MainHeaderView: View {
    @ObservedObject var workout: Workout
    
    var headerTitle: String
    
    var onAddClicked: () -> Void
    
    var body: some View {
        HStack {
            Text(headerTitle)
            Spacer()
            Button(action: onAddClicked) {
                Image(systemName: "plus.circle.fill")
            }
            .disabled(workout.mainExercise != nil)
        }
    }
}
struct SupplementalHeaderView: View {
    @ObservedObject var workout: Workout
    
    var headerTitle: String
    
    var onAddClicked: () -> Void
    
    var body: some View {
        HStack {
            Text(headerTitle)
            Spacer()
            Button(action: onAddClicked) {
                Image(systemName: "plus.circle.fill")
            }
            .disabled(workout.supplementalExercise != nil)
        }
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
