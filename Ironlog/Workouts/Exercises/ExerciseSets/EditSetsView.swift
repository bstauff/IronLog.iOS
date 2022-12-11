//
//  EditSetsView.swift
//  Ironlog
//
//  Created by Brian Stauff on 11/19/22.
//

import SwiftUI

struct EditSetsView: View {
    @Binding var updatedSets: [ExerciseSetModel]
    
    var body: some View {
        List {
            HStack {
                Spacer()
                Text("Reps")
                Spacer()
                Text("Weight")
                Spacer()
            }
            ForEach(updatedSets) { updatedSet in
                HStack {
                    Spacer()
                    Text("\(updatedSet.reps)")
                    Spacer()
                    Text("\(updatedSet.weight)")
                    Spacer()
                }
            }
            .onDelete{ indexSet in
                updatedSets.remove(atOffsets: indexSet)
            }
            AddSetView { exerciseSet in
                updatedSets.append(exerciseSet)
            }
        }
    }
}

struct EditSetsView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let setA = ExerciseSetModel(context: viewContext)
        setA.reps = 5
        setA.weight = 250
        let setB = ExerciseSetModel(context: viewContext)
        setB.reps = 10
        setB.weight = 500
        let exerciseSets = [
            setA,
            setB
        ]
        return EditSetsView(updatedSets: .constant(exerciseSets))
            .environment(\.managedObjectContext, viewContext)
    }
}
