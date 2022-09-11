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
    
    @State private var lifts: [Lift] = []
    
    var workoutRepository: AppRepository
    
    init(workoutRepo: AppRepository) {
        self.workoutRepository = workoutRepo
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach($workouts){ $workout in
                        NavigationLink(getWorkoutDate(workout: workout), destination: WorkoutDetailsView(repo: workoutRepository, workout: workout, lifts: $lifts))
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
                        AddWorkoutView(repo: self.workoutRepository, workouts: $workouts)
                    }
                }
            }
        }.onAppear(perform: loadData)
    }
    func getWorkoutDate(workout: Workout) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YY"
        return dateFormatter.string(from: workout.date)
    }
    func loadData() {
        loadWorkouts()
        loadLifts()
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
    func deleteWorkouts(offsets: IndexSet) {
        do {
            for offset in offsets {
                let workoutToDelete = self.workouts[offset]
                
                try workoutRepository.deleteWorkout(workoutId: workoutToDelete.id)
            }
            
            self.workouts.remove(atOffsets: offsets)
        } catch {
            isError = true
            errorString = "Failed to delete.  Please try again."
        }
    }
    func loadLifts() {
        do {
            let lifts = try self.workoutRepository.getAllLifts()
            self.lifts = lifts
        } catch {
            isError = true
            errorString = "Failed to load lifts"
        }
    }
}


struct CycleView_Previews: PreviewProvider {
    static var previews: some View {
        let workoutA = Workout(date: Date())
        let workoutB = Workout(date: Calendar.current.date(byAdding: .day, value: 1, to: Date())!)
        let workoutRepo = CoreDataRepository()
        try? workoutRepo.addWorkout(workout: workoutA)
        try? workoutRepo.addWorkout(workout: workoutB)
        return WorkoutsView(workoutRepo: workoutRepo)
    }
}
