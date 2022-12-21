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
    var lifts: FetchedResults<LiftModel>
    
    @ObservedObject var exercise: ExerciseModel
    
    @State var updatedLift: LiftModel?
    @State var updatedSets: [ExerciseSetModel] = []
    
    @State private var isError = false
    @State private var errorMessage = ""
    
    
    var onExerciseEdited: () -> Void
    
    var body: some View {
        VStack {
            Form {
                Picker("Lift", selection: $updatedLift) {
                    ForEach(lifts) { lift in
                        Text(lift.name ?? "").tag(lift as LiftModel?)
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
            updatedLift = exercise.exerciseLift
            updatedSets = exercise.exerciseSets?.array as! [ExerciseSetModel]
        }
    }
    
    private func updateExercise() -> Void {
        exercise.exerciseLift = updatedLift
        var setsToRemove: [ExerciseSetModel] = []
        for exerciseSet in exercise.exerciseSets!.array as! [ExerciseSetModel] {
            if !updatedSets.contains(exerciseSet) {
                setsToRemove.append(exerciseSet)
            }
        }
        
        var setsToAdd: [ExerciseSetModel] = []
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
        
        let exercise = ExerciseModel(context: viewContext)
        
        return NavigationView {
            EditExerciseView(exercise: exercise) {
                
            }
            .environment(\.managedObjectContext, viewContext)
        }
    }
}
