//
//  CycleView.swift
//  Ironlog
//
//  Created by Brian Stauff on 2/19/22.
//

import SwiftUI

struct WorkoutsView: View {
    @State private var newWorkout: Workout? = nil
    @State private var isShowingWorkoutSheet = false
    @State private var workouts: [Workout] = []
    
    @State private var isError = false
    @State private var errorString = ""
    
    var workoutRepository: WorkoutRepository
    
    init(workoutRepo: WorkoutRepository) {
        self.workoutRepository = workoutRepo
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach($workouts){ $workout in
                        NavigationLink(getWorkoutDate(workout: workout), destination: WorkoutView(workout: workout, cycle: cycle, liftCatalog: liftCatalog))
                    }
                    .onDelete { indexSet in
                        workouts.remove(atOffsets: indexSet)
                    }
                }
            }
            .navigationTitle("Cycle")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("add") {
                        self.isShowingWorkoutSheet = true
                    }.sheet(isPresented: $isShowingWorkoutSheet) {
                        AddCycleWorkoutView(cycle: self.cycle)
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
    func loadWorkouts() {
        do {
            let workouts = try self.workoutRepository.getAllWorkouts()
            self.workouts = workouts
        } catch {
            isError = true
            errorString = "Failed to load workouts"
        }
        
    }
}


struct CycleView_Previews: PreviewProvider {
    static var previews: some View {
        let workoutRepo = CoreDataWorkoutRepository()
        return WorkoutsView(workoutRepo: workoutRepo)
    }
}
