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
    @State var updatedSets: [ExerciseSetModel] = []
    
    @ObservedObject var exercise: ExerciseModel
    
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
            updatedSets = exercise.exerciseSets?.array as! [ExerciseSetModel]
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
