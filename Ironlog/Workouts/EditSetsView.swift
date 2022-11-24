//
//  EditSetsView.swift
//  Ironlog
//
//  Created by Brian Stauff on 11/19/22.
//

import SwiftUI

struct EditSetsView: View {
    @Binding var updatedSets: [ExerciseSet]
    
    @State private var newReps: Int = 0
    @State private var newWeight: Int = 0
    @State private var isError: Bool = false
    @State private var errorMessage: String = ""
    
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
                TextField("Reps", value: $newReps, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                Spacer()
                TextField("Weight", value: $newWeight, formatter: NumberFormatter())
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                Spacer()
                Button(action: {}) {
                    Image(systemName: "plus.circle.fill")
                }
                    .disabled(areNewInputsInvalid())
                    .alert("Oops", isPresented: $isError) {
                        Button("Ok"){
                            isError = false
                            errorMessage = ""
                        }
                    } message: {
                        Text(errorMessage)
                    }
                Spacer()
            }
        }
    }
    
    private func areNewInputsInvalid() -> Bool {
        return
            self.newReps == 0 ||
            self.newWeight == 0
    }
    private func addNewSet() {
        guard self.newReps != 0 && self.newWeight != 0 else {
            self.isError = true
            self.errorMessage = "Reps and Sets must have a value"
            return
        }
        let newSet = ExerciseSet(reps: self.newReps, weight: self.newWeight)
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
