//
//  EditExerciseView.swift
//  Ironlog
//
//  Created by Brian Stauff on 4/30/22.
//

import SwiftUI

struct ExerciseDetailsView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @State private var isError = false
    @State private var errorMessage = ""
    
    @State private var shouldShowEditSheet = false
    
    @ObservedObject var exercise: ExerciseModel
    
    var body: some View {
        VStack {
            Form {
                Section(header: Text("Sets")) {
                    HStack {
                        Text("Reps")
                        Spacer()
                        Text("Weight")
                    }
                    List {
                        ForEach(exercise.exerciseSets?.allObjects as! [ExerciseSetModel]){ exerciseSet in
                            HStack {
                                Text(String(exerciseSet.reps))
                                Spacer()
                                Text(String(exerciseSet.weight))
                            }
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $shouldShowEditSheet) {
            EditExerciseView(exercise: self.exercise) {
                
            }
        }
        .toolbar {
            Button("Edit") {
                self.shouldShowEditSheet = true
            }
        }
    }
}

struct ExerciseDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        
        let exercise = ExerciseModel(context: viewContext)
        exercise.isComplete = false
        
        let lift = LiftModel(context: viewContext)
        lift.name = "Squat"
        lift.trainingMax = 315
        lift.id = UUID()
        
        exercise.exerciseLift = lift
        
        let setA = ExerciseSetModel(context: viewContext)
        setA.id = UUID()
        setA.isComplete = false
        setA.reps = 5
        setA.weight = 315
        
        let setB = ExerciseSetModel(context: viewContext)
        setB.id = UUID()
        setB.isComplete = false
        setB.reps = 5
        setB.weight = 315
        
        let exerciseSets = [setA, setB]
        
        exercise.exerciseSets = NSSet(array: exerciseSets)
        
        return ExerciseDetailsView(exercise: exercise)
            .environment(\.managedObjectContext, viewContext)
    }
}
