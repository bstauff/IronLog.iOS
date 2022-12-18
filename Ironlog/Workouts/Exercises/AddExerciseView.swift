//
//  WorkoutAddExerciseView.swift
//  Ironlog
//
//  Created by Brian Stauff on 4/23/22.
//

import SwiftUI

struct AddExerciseView: View {
    @Environment(\.presentationMode) var presentationMode
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var lifts: FetchedResults<LiftModel>
    
    @State private var selectedLift: LiftModel?
    @State private var sets: [ExerciseSetModel] = []
    
    @State private var isError = false
    @State private var errorMessage = ""
    
    var onExerciseAdded: (_ newExercise: ExerciseModel) -> Void
    
    var body: some View {
        NavigationView{
            VStack {
                Form {
                    Picker("Lift", selection: $selectedLift) {
                        ForEach(lifts) { lift in
                            Text(lift.name ?? "").tag(lift as LiftModel?)
                        }
                    }
                    Section {
                        EditSetsView(updatedSets: $sets)
                    }
                    Section {
                        HStack {
                            Spacer()
                            Button("Save") {
                                createNewExercise()
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
        }.onAppear {
            if self.selectedLift == nil {
                self.selectedLift = lifts.first
            }
        }
    }
        
    func createNewExercise() -> Void {
        guard selectedLift != nil else {
            isError = true
            errorMessage = "Must select a lift"
            return
        }
                        
        guard !sets.isEmpty else {
            isError = true
            errorMessage = "Must add sets"
            return
        }
        
        let newExercise = ExerciseModel(context: viewContext)
        let orderedSet = NSOrderedSet(array:sets)
        newExercise.addToExerciseSets(orderedSet)
        newExercise.exerciseLift = self.selectedLift
        newExercise.id = UUID()
        newExercise.isComplete = false
        
        do {
            try viewContext.save()
        } catch {
            self.isError = true
            self.errorMessage = "Failed to save exercise"
            return
        }
        
        self.onExerciseAdded(newExercise)
    }
}

struct AddExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        return
            AddExerciseView{ newExercise in
            
            }
            .environment(\.managedObjectContext, viewContext)
    }
}
