//
//  WorkoutDetailsMainView.swift
//  Ironlog
//
//  Created by Brian Stauff on 12/28/22.
//

import SwiftUI
import CoreData

struct MainView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @ObservedObject var workout: FslAmrapWorkout
    
    @State private var isShowingAddMainSheet = false
    @State private var isError = false
    @State private var errorMessage = ""
    
    var body: some View {
        Section(
            header:
                ExerciseHeaderView(
                    headerTitle: "Main",
                    onAddClicked: {() -> Void in self.isShowingAddMainSheet = true},
                    isAddDisabled: {() -> Bool in self.workout.mainExercise != nil}
        )) {
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
        .alert(isPresented: $isError) {
            Alert(
                title: Text("Error"),
                message: Text(self.errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext

        let workoutFetchRequest: NSFetchRequest<FslAmrapWorkout> = FslAmrapWorkout.fetchRequest()

        let workout = try! viewContext.fetch(workoutFetchRequest).first!
        NavigationView {
            List {
                MainView(workout: workout)
            }
        }
            .environment(\.managedObjectContext, viewContext)
    }
}
