//
//  CycleView.swift
//  Ironlog
//
//  Created by Brian Stauff on 2/19/22.
//

import SwiftUI

struct WorkoutsView: View {
    @Binding var workouts: [Workout]
    @Binding var lifts: [Lift]
    
    @State private var isShowingWorkoutSheet = false
    @State private var isError = false
    @State private var errorString = ""
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach($workouts){ $workout in
                        NavigationLink(
                            getWorkoutDate(workout: workout),
                            destination:
                                WorkoutDetailsView(workout: workout))
                    }
                    .onDelete(perform: deleteWorkouts)
                }
            }
            .navigationTitle("Workouts")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("add") {
                        self.isShowingWorkoutSheet = true
                    }.sheet(isPresented: $isShowingWorkoutSheet) {
                        AddWorkoutView()
                    }
                }
            }
        }
    }
    func getWorkoutDate(workout: Workout) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY"
        return dateFormatter.string(from: workout.date)
    }
    func deleteWorkouts(offsets: IndexSet) {
        do {
            for offset in offsets {
                let workoutToDelete = self.workouts[offset]
            }
            
            self.workouts.remove(atOffsets: offsets)
        } catch {
            isError = true
            errorString = "Failed to delete.  Please try again."
        }
    }
}


struct CycleView_Previews: PreviewProvider {
    static var previews: some View {
        let workoutA = Workout(date: Date())
        let workoutB = Workout(date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!)
        let workouts = [workoutA, workoutB]
        
        let lift = Lift(name: "Squat", trainingMax: 350)
        let workoutRepo = CoreDataRepository()
        
        return WorkoutsView(workoutRepo: workoutRepo, workouts: .constant(workouts), lifts: .constant([lift]))
    }
}
