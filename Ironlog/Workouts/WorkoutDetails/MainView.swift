//
//  WorkoutDetailsMainView.swift
//  Ironlog
//
//  Created by Brian Stauff on 12/28/22.
//

import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @ObservedObject var workout: Workout
    
    @State private var isShowingAddMainSheet = false
    @State private var isError = false
    @State private var errorMessage = ""
    
    var body: some View {
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
        .sheet(isPresented: $isShowingAddMainSheet) {
            AddMainView(workout: workout)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let workoutFetchRequest = Workout.fetchRequest()

        let workout = try! viewContext.fetch(workoutFetchRequest).first!
        NavigationView {
            List {
                MainView(workout: workout)
            }
        }
            .environment(\.managedObjectContext, viewContext)
    }
}
