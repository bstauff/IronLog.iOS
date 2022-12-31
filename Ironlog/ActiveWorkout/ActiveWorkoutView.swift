//
//  ActiveWorkoutView.swift
//  Ironlog
//
//  Created by Brian Stauff on 3/26/22.
//

import SwiftUI

struct ActiveWorkoutView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors:[SortDescriptor(\FslAmrapWorkout.date)]) var workouts: FetchedResults<FslAmrapWorkout>
    
    @State private var isError = false
    @State private var errorMessage = ""
    
    @State private var selectedWorkout: FslAmrapWorkout? = nil
    
    var body: some View {
        List {
            Section {
                WorkoutSelection() { updatedWorkoutSelection in
                    selectedWorkout = updatedWorkoutSelection
                }
            }
            if(selectedWorkout != nil) {
                //                    WorkoutCompletionView(workout: selectedWorkout!)
                Section{
                    NavigationStack {
                        ForEach(getSelectedWarmups()){ warmup in
                            NavigationLink(warmup.lift?.name ?? "") {
                                ActiveWarmUpView()
                            }
                        }
                        //                    .navigationDestination(for: WarmupExercise.self) { warmup in
                        //                        ActiveWarmUpView()
                        //                    }
                    }
                }
            } else {
                Text("No workout selected")
            }
        }
        .alert(isPresented: $isError) {
            Alert(
                title: Text("oops"),
                message: Text("Failed to save workout"),
                dismissButton: .default(Text("OK")))
        }
    }
    
    private func getSelectedWarmups() -> [WarmupExercise] {
        return selectedWorkout?.warmupExercises?.array as? [WarmupExercise] ?? []
    }
}

struct ActiveWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        ActiveWorkoutView()
            .environment(\.managedObjectContext, viewContext)
    }
}
