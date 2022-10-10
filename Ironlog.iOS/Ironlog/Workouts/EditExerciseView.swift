//
//  EditExerciseView.swift
//  Ironlog
//
//  Created by Brian Stauff on 9/20/22.
//

import SwiftUI

struct EditExerciseView: View {
    @State private var isError = false
    @State private var errorMessage = ""
    
    @State private var newReps = ""
    @State private var newWeight = ""
    
    @Binding private var updatedLift: Lift
    @Binding private var updatedSets: [ExerciseSet]
    
    @Binding private var lifts: [Lift]
    
    init(
        lifts: Binding<[Lift]>,
        updatedLift: Binding<Lift>,
        updatedSets: Binding<[ExerciseSet]>) {
            self._lifts = lifts
            self._updatedLift = updatedLift
            self._updatedSets = updatedSets
    }
    
    var body: some View {
        VStack {
            Form {
                Picker("Lift", selection: $updatedLift) {
                    ForEach($lifts) { $lift in
                        Text(lift.name).tag(lift)
                    }
                }
                Section {
                    HStack {
                        Text("Reps")
                        Spacer()
                        Text("Weight")
                    }
                    List {
                        ForEach(updatedSets){ exerciseSet in
                            HStack {
                                Text(String(exerciseSet.reps))
                                Spacer()
                                Text(String(exerciseSet.weight))
                            }
                        }
                        .onDelete{ indexSet in
                            updatedSets.remove(atOffsets: indexSet)
                        }
                        HStack {
                            TextField("Reps", text: $newReps)
                                .keyboardType(.decimalPad)
                            TextField("Weight", text: $newWeight)
                                .keyboardType(.decimalPad)
                            Button(action: {
                                withAnimation {
                                    let newRepsInt = Int(newReps)
                                    let newRepsWeight = Int(newWeight)
                                    guard newRepsInt != nil  && newRepsWeight != nil else {
                                        isError = true
                                        errorMessage = "invalid reps or weight"
                                        newReps = ""
                                        newWeight = ""
                                        return
                                    }
                                    
                                    let newSet =
                                        ExerciseSet(
                                            reps: newRepsInt!,
                                            weight: newRepsWeight!)
                                    updatedSets.append(newSet)
                                    newReps = ""
                                    newWeight = ""
                                }
                            }) {
                                Image(systemName: "plus.circle.fill")
                            }
                            .disabled(newReps.isEmpty || newWeight.isEmpty)
                        }
                    }
                    
                }
            }
        }
    }
}

struct EditExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        let squat = Lift(name: "Squat", trainingMax: 315)
        let bench = Lift(name: "Bench", trainingMax: 275)
        let lifts = [squat, bench]
        let sets = [
            ExerciseSet(reps: 5, weight: 250)
        ]
        
        return NavigationView {
            EditExerciseView(
                lifts: .constant(lifts),
                updatedLift: .constant(squat),
                updatedSets: .constant(sets)
            )
        }
    }
}
