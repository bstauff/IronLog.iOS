//
//  WorkoutDetailsWarmUpView.swift
//  Ironlog
//
//  Created by Brian Stauff on 12/28/22.
//

import SwiftUI

struct WarmUpView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @ObservedObject var workout: Workout
    
    @State private var isError = false
    @State private var errorMessage = ""
    @State private var isShowingAddWarmUpSheet = false
    
    var warmUpExercises: [WarmupExercise] {
        return workout.warmupExercises?.array as? [WarmupExercise] ?? []
    }
    
    var body: some View {
        Section(
            header:
                ExerciseHeaderView(
                    headerTitle: "Warm Up Lifts",
                    onAddClicked: {() -> Void in self.isShowingAddWarmUpSheet = true},
                    isAddDisabled: {() -> Bool in false}
        )) {
                if warmUpExercises.count > 0 {
                    ForEach(warmUpExercises){ warmupExercise in
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
        .alert(isPresented: $isError) {
            Alert(
                title: Text("Error"),
                message: Text(self.errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }
        .sheet(isPresented: $isShowingAddWarmUpSheet) {
            AddWarmUpView(workout: workout)
        }
    }
    
    func deleteWarmups(indexSet: IndexSet) {
        for index in indexSet {
            let warmup = warmUpExercises[index]
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
}

struct WarmUpView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let workoutFetchRequest = Workout.fetchRequest()

        let workout = try! viewContext.fetch(workoutFetchRequest).first!
        NavigationView {
            List {
                WarmUpView(workout: workout)
            }
        }
            .environment(\.managedObjectContext, viewContext)
    }
}
