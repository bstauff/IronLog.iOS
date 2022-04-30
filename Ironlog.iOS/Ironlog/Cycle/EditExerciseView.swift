//
//  EditExerciseView.swift
//  Ironlog
//
//  Created by Brian Stauff on 4/30/22.
//

import SwiftUI

struct EditExerciseView: View {
    @ObservedObject var liftCatalog: LiftCatalog
    @ObservedObject var exercise: Exercise
    
    @State private var shouldNavigate = false
    
    @State private var isError = false
    @State private var errorMessage = ""
    
    var body: some View {
        VStack {
            NavigationLink(
                destination:AddSetToExerciseSheet(exerciseSets: $exercise.sets),
                isActive: $shouldNavigate) {
                    EmptyView()
                }
            Form {
                Picker("Lift", selection: $exercise.lift) {
                    ForEach($liftCatalog.lifts) { $lift in
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
                        ForEach($exercise.sets){ $exerciseSet in
                            HStack {
                                Text(String(exerciseSet.reps))
                                Spacer()
                                Text(String(exerciseSet.weight))
                            }
                        }
                        .onDelete{ indexSet in
                            exercise.sets.remove(atOffsets: indexSet)
                        }
                        Button("Add Set") {
                            shouldNavigate = true
                        }
                    }
                    
                }
            }
        }
    }
}

struct EditExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        let liftCatalog = LiftCatalog()
        let squatLift = Lift(name: "Squat", trainingMax: 315)
        liftCatalog.lifts.append(squatLift)
        let exercise = Exercise()
        return EditExerciseView(liftCatalog: liftCatalog, exercise: exercise)
    }
}
