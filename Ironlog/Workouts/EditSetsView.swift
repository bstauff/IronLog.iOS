//
//  EditSetsView.swift
//  Ironlog
//
//  Created by Brian Stauff on 11/19/22.
//

import SwiftUI

struct EditSetsView: View {
    @Binding var updatedSets: [ExerciseSet]
    
    @State private var newReps: String = ""
    @State private var newWeight: String = ""
    
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
            HStack {
                Spacer()
                TextField("Reps", text: $newReps)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                Spacer()
                TextField("Weight", text: $newWeight)
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                Spacer()
                Button(action: {}) {
                    Image(systemName: "plus.circle.fill")
                }.disabled(areNewInputsInvalid())
                Spacer()
            }
        }
    }
    
    private func areNewInputsInvalid() -> Bool {
        return
            self.newReps.isEmpty ||
            self.newWeight.isEmpty
            
    }
}

struct EditSetsView_Previews: PreviewProvider {
    static var previews: some View {
        let exerciseSets = [
            ExerciseSet(reps: 5, weight: 250),
            ExerciseSet(reps: 5, weight: 275),
            ExerciseSet(reps: 5, weight: 300)
        ]
        EditSetsView(updatedSets: .constant(exerciseSets))
    }
}
