//
//  EditExerciseView.swift
//  Ironlog
//
//  Created by Brian Stauff on 9/20/22.
//

import SwiftUI

struct EditExerciseView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var viewContext
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)])
    var lifts: FetchedResults<Lift>
    
    @ObservedObject var exercise: Exercise
    
    @State var updatedLift: Lift?
    @State var updatedSets: [ExerciseSet] = []
    
    @State private var isError = false
    @State private var errorMessage = ""
    
    
    var onExerciseEdited: () -> Void
    
    var body: some View {
        VStack {
            Form {
                Picker("Lift", selection: $updatedLift) {
                    ForEach(lifts) { lift in
                        Text(lift.name ?? "").tag(lift as Lift?)
                    }
                }
                Section {
                    EditSetsView(updatedSets: $updatedSets)
                }
                Section {
                    HStack {
                        Spacer()
                        Button("Save") {
                            updateExercise()
                            presentationMode.wrappedValue.dismiss()
                        }
                            .buttonStyle(.borderedProminent)
                            .alert(isPresented: $isError) {
                                Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                            }
                        Spacer()
                    }
                }
            }
        }
        .onAppear {
            updatedLift = exercise.lift
            updatedSets = exercise.exerciseSets?.array as! [ExerciseSet]
        }
    }
    
    private func updateExercise() -> Void {
        exercise.lift = updatedLift
        var setsToRemove: [ExerciseSet] = []
        for exerciseSet in exercise.exerciseSets!.array as! [ExerciseSet] {
            if !updatedSets.contains(exerciseSet) {
                setsToRemove.append(exerciseSet)
            }
        }
        
        var setsToAdd: [ExerciseSet] = []
        for exerciseSet in updatedSets {
            if !exercise.exerciseSets!.contains(exerciseSet) {
                setsToAdd.append(exerciseSet)
            }
        }
        
        for exerciseSet in setsToRemove {
            exercise.removeFromExerciseSets(exerciseSet)
            self.viewContext.delete(exerciseSet)
        }
        
        for exerciseSet in setsToAdd {
            exercise.addToExerciseSets(exerciseSet)
        }
        
        do {
            try self.viewContext.save()
        } catch {
            self.isError = true
            self.errorMessage = "Failed to update exercise"
        }
    }
}

struct EditExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        
        let exercise = Exercise(context: viewContext)
        
        return NavigationView {
            EditExerciseView(exercise: exercise) {
                
            }
            .environment(\.managedObjectContext, viewContext)
        }
    }
}
