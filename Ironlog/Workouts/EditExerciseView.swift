//
//  EditExerciseView.swift
//  Ironlog
//
//  Created by Brian Stauff on 9/20/22.
//

import SwiftUI

struct EditExerciseView: View {
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
                    EditSetsView(updatedSets: $updatedSets)
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
