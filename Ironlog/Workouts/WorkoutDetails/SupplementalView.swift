//
//  SupplementalView.swift
//  Ironlog
//
//  Created by Brian Stauff on 12/28/22.
//

import SwiftUI
import CoreData

struct SupplementalView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @ObservedObject var workout: FslAmrapWorkout
    
    @State private var isShowingAddSupplementalSheet = false
    @State private var isError = false
    @State private var errorMessage = ""
    
    var body: some View {
        Section(
            header:
                ExerciseHeaderView(
                    headerTitle: "Supplemental",
                    onAddClicked: {() -> Void in self.isShowingAddSupplementalSheet = true},
                    isAddDisabled: {() -> Bool in self.workout.supplementalExercise != nil}
        )) {
            if self.workout.supplementalExercise != nil {
                NavigationLink(
                    destination: ExerciseDetailsView(exercise: self.workout.supplementalExercise!)) {
                    ExerciseRowView(exercise: self.workout.supplementalExercise!)
                }
            } else {
                Text("Go add some supplemental work!")
            }
        }
        .sheet(isPresented: $isShowingAddSupplementalSheet) {
            AddSupplementalView(workout: workout)
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

struct SupplementalView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext

        let workoutFetchRequest: NSFetchRequest<FslAmrapWorkout> = FslAmrapWorkout.fetchRequest()

        let workout = try! viewContext.fetch(workoutFetchRequest).first!
        NavigationView {
            List {
                SupplementalView(workout: workout)
            }
        }
            .environment(\.managedObjectContext, viewContext)
    }
}
