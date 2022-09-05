//
//  CycleView.swift
//  Ironlog
//
//  Created by Brian Stauff on 2/19/22.
//

import SwiftUI

struct WorkoutsView: View {
    @State private var isShowingWorkoutSheet = false
    @State private var workouts: [Workout] = []
    
    @State private var isError = false
    @State private var errorString = ""
    
    var workoutRepository: AppRepository
    
    init(workoutRepo: AppRepository) {
        self.workoutRepository = workoutRepo
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach($workouts){ $workout in
                        NavigationLink(getWorkoutDate(workout: workout), destination: WorkoutDetailsView(workout: workout, cycle: cycle, liftCatalog: liftCatalog))
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
                        AddWorkoutView(repo: self.workoutRepository, workouts: $workouts)
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
        let workoutRepo = CoreDataRepository()
        return WorkoutsView(workoutRepo: workoutRepo)
    }
}
