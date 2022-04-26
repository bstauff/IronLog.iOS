//
//  CycleView.swift
//  Ironlog
//
//  Created by Brian Stauff on 2/19/22.
//

import SwiftUI

struct CycleView: View {
    @ObservedObject var cycle: Cycle
    @ObservedObject var liftCatalog: LiftCatalog
    @State private var newWorkout: Workout? = nil
    @State private var isShowingWorkoutSheet = false
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach($cycle.workouts){ $workout in
                        NavigationLink(getWorkoutDate(workout: workout), destination: WorkoutView(workout: workout, cycle: cycle, liftCatalog: liftCatalog))
                    }
                    .onDelete { indexSet in
                        cycle.workouts.remove(atOffsets: indexSet)
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
}


struct CycleView_Previews: PreviewProvider {
    static var previews: some View {
        let cycle = Cycle()
        let liftCatalog = LiftCatalog()
        return CycleView(cycle: cycle, liftCatalog: liftCatalog)
    }
}
