//
//  WorkoutSelection.swift
//  Ironlog
//
//  Created by Brian Stauff on 10/7/22.
//

import SwiftUI

struct WorkoutSelection: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors:[SortDescriptor(\WorkoutModel.date, order: .reverse)]) var workouts: FetchedResults<WorkoutModel>
    
    var onWorkoutSelected: (_ selectedWorkout: WorkoutModel?) -> Void
    
    @State var selectedWorkout: WorkoutModel? = nil
    
    var body: some View {
        Picker("Workout", selection: $selectedWorkout) {
            ForEach(workouts) { workout in
                Text(getWorkoutDate(workout: workout)).tag(workout as WorkoutModel?)
            }
        }
        .onChange(of: selectedWorkout) { updatedWorkout in
            onWorkoutSelected(updatedWorkout)
        }
        .onAppear {
            self.selectedWorkout = workouts.first
        }
    }
    func getWorkoutDate(workout: WorkoutModel) -> String{
        guard workout.date != nil else  {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY"
        return dateFormatter.string(from: workout.date!)
    }
}

struct WorkoutSelection_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        WorkoutSelection() { workoutSelected in
            
        }
            .environment(\.managedObjectContext, viewContext)
    }
}
