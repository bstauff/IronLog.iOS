//
//  AddWarmUp.swift
//  Ironlog
//
//  Created by Brian Stauff on 12/27/22.
//

import SwiftUI

struct AddWarmUpView: View {
    @Environment(\.presentationMode)
    var presentationMode
    
    @Environment(\.managedObjectContext)
    var viewContext
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)])
    var lifts: FetchedResults<Lift>
    
    @ObservedObject
    var workout: Workout
    
    @State private var selectedLift: Lift?
    @State private var sets: [ExerciseSet] = []
    
    @State private var isError = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationView{
            VStack {
                Form {
                    Picker("Lift", selection: $selectedLift) {
                        ForEach(lifts) { lift in
                            Text(lift.name ?? "").tag(lift as Lift?)
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
        
        let newExercise = WarmupExercise(context: viewContext)
        let orderedSet = NSOrderedSet(array:sets)
        newExercise.addToExerciseSets(orderedSet)
        newExercise.lift = self.selectedLift
        newExercise.id = UUID()
        newExercise.isComplete = false
        
        newExercise.workout = self.workout
        
        workout.addToWarmupExercises(newExercise)
        
        do {
            try viewContext.save()
        } catch {
            self.isError = true
            self.errorMessage = "Failed to save exercise"
            return
        }
    }
}

struct AddWarmUpView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let workout = try! viewContext.fetch(Workout.fetchRequest()).first!
        
        AddWarmUpView(workout: workout)
                .environment(\.managedObjectContext, viewContext)
    }
}
