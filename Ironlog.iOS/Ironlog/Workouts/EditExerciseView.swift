//
//  EditExerciseView.swift
//  Ironlog
//
//  Created by Brian Stauff on 4/30/22.
//

import SwiftUI

struct EditExerciseView: View {
    @State private var shouldNavigate = false
    @State private var isError = false
    @State private var errorMessage = ""
    
    @State private var lifts: [Lift] = []
    
    private var repo: AppRepository
    
    @ObservedObject var exercise: Exercise
    
    init(repo: AppRepository, exercise: Exercise) {
        self.repo = repo
        self.exercise = exercise
    }
    
    var body: some View {
        VStack {
            NavigationLink(
                destination:AddSetToExerciseSheet(exerciseSets: $exercise.sets),
                isActive: $shouldNavigate) {
                    EmptyView()
                }
            Form {
                Picker("Lift", selection: $exercise.lift) {
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
    
    private func loadLifts() {
        do {
            let lifts = try repo.getAllLifts()
            self.lifts = lifts
        } catch {
            isError = true
            errorMessage = "Failed to load lifts"
        }
    }
}

struct EditExerciseView_Previews: PreviewProvider {
    static var previews: some View {
        let liftRepo = CoreDataRepository()
        let squat = Lift(name: "Squat", trainingMax: 315)
        try? liftRepo.addLift(lift: squat)
        let exercise = Exercise()
        return EditExerciseView(repo: liftRepo, exercise: exercise)
    }
}
