//
//  AssistanceView.swift
//  Ironlog
//
//  Created by Brian Stauff on 12/28/22.
//

import SwiftUI

struct AssistanceView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @ObservedObject var workout: Workout
    
    @State private var isShowingAddAssistanceSheet = false
    @State private var isError = false
    @State private var errorMessage = ""
    
    var assistanceExercises: [AssistanceExercise] {
        return workout.assistanceExercises?.array as? [AssistanceExercise] ?? []
    }
    
    var body: some View {
        Section(
            header:
                ExerciseHeaderView(
                    headerTitle: "Warm Up Lifts",
                    onAddClicked: {() -> Void in self.isShowingAddAssistanceSheet = true},
                    isAddDisabled: {() -> Bool in false}
        )) {
            if assistanceExercises.count > 0 {
                ForEach(assistanceExercises){ assistanceExercise in
                    NavigationLink(
                        destination: ExerciseDetailsView(exercise: assistanceExercise)) {
                        ExerciseRowView(exercise: assistanceExercise)
                    }
                }
                .onDelete(perform: deleteAssistance)
            } else {
                Text("Go add some assistance work!")
            }
        }
        .sheet(isPresented: $isShowingAddAssistanceSheet) {
            AddAssistanceView(workout: workout)
        }
        .alert(isPresented: $isError) {
            Alert(
                title: Text("Error"),
                message: Text(self.errorMessage),
                dismissButton: .default(Text("OK"))
            )
        }
    }
    
    func deleteAssistance(indexSet: IndexSet) {
        for index in indexSet {
            let assistance = assistanceExercises[index]
            workout.removeFromAssistanceExercises(assistance)
            self.viewContext.delete(assistance)
        }
        
        do {
            try self.viewContext.save()
        } catch {
            self.isError = true
            self.errorMessage = "Failed to delete lift"
            return
        }
    }
}

struct AssistanceView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let workoutFetchRequest = Workout.fetchRequest()

        let workout = try! viewContext.fetch(workoutFetchRequest).first!
        NavigationView {
            List {
                AssistanceView(workout: workout)
            }
        }
            .environment(\.managedObjectContext, viewContext)
    }
}
