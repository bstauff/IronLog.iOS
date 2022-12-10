//
//  EditExerciseView.swift
//  Ironlog
//
//  Created by Brian Stauff on 9/20/22.
//

import SwiftUI

struct EditExerciseView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var lifts: FetchedResults<LiftModel>
    
    @State var updatedLift: LiftModel?
    @State var updatedSets: [ExerciseSetModel]
    
    @Binding var exercise: ExerciseModel
    
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
            }
        }
        .onAppear {
            updatedLift = exercise.exerciseLift
            updatedSets = exercise.exerciseSets
        }
    }
}

struct EditExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        let squat = Lift(name: "Squat", trainingMax: 315)
        let sets = [
            ExerciseSet(reps: 5, weight: 250)
        ]
        
        let viewContext = PersistenceController.preview.container.viewContext
        
        return NavigationView {
            EditExerciseView(
            ){
                
            }
            .environment(\.managedObjectContext, viewContext)
        }
    }
}
