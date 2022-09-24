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
    
    @Binding private var updatedLift: Lift
    @Binding private var updatedSets: [ExerciseSet]
    
    @Binding private var lifts: [Lift]
    
    private var repo: AppRepository
    
    @ObservedObject var exercise: Exercise
    
    init(
        repo: AppRepository,
        exercise: Exercise,
        lifts: Binding<[Lift]>,
        updatedLift: Binding<Lift>,
        updatedSets: Binding<[ExerciseSet]>) {
            self.repo = repo
            self.exercise = exercise
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
                        ForEach($updatedSets){ $exerciseSet in
                            HStack {
                                Text(String(exerciseSet.reps))
                                Spacer()
                                Text(String(exerciseSet.weight))
                            }
                        }
                        .onDelete{ indexSet in
                            updatedSets.remove(atOffsets: indexSet)
                        }
                        Button("Add Set") {
                        }
                    }
                    
                }
            }
        }
    }
}

struct EditExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        let liftRepo = CoreDataRepository()
        let squat = Lift(name: "Squat", trainingMax: 315)
        let bench = Lift(name: "Bench", trainingMax: 275)
        let lifts = [squat, bench]
        let sets = [
            ExerciseSet(reps: 5, weight: 250)
        ]
        let exercise = Exercise(id: UUID(), sets: sets, lift: squat, isComplete: false)
        return NavigationView {
            EditExerciseView(
                repo: liftRepo,
                exercise: exercise,
                lifts: .constant(lifts),
                updatedLift: .constant(exercise.lift),
                updatedSets: .constant(exercise.sets)
            )
        }
    }
}
