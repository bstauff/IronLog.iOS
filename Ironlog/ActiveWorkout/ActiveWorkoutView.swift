//
//  ActiveWorkoutView.swift
//  Ironlog
//
//  Created by Brian Stauff on 3/26/22.
//

import SwiftUI

struct ActiveWorkoutView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors:[SortDescriptor(\WorkoutModel.date)]) var workouts: FetchedResults<WorkoutModel>
    
    @State private var isError = false
    @State private var errorMessage = ""
    
    @State private var selectedWorkout: WorkoutModel? = nil
    
    var body: some View {
        NavigationView {
            List {
                WorkoutSelection() { updatedWorkoutSelection in
                    selectedWorkout = updatedWorkoutSelection
                }
                if(selectedWorkout != nil) {
                    WorkoutCompletionView(workout: selectedWorkout!)
                } else {
                    Text("No workout selected")
                }
            }
        }
        .alert(isPresented: $isError) {
            Alert(
                title: Text("oops"),
                message: Text("Failed to save workout"),
                dismissButton: .default(Text("OK")))
        }
    }
}

struct ActiveWorkoutView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        ActiveWorkoutView()
            .environment(\.managedObjectContext, viewContext)
    }
}
