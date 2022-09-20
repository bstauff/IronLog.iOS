//
//  EditExerciseView.swift
//  Ironlog
//
//  Created by Brian Stauff on 4/30/22.
//

import SwiftUI

struct ExerciseDetailsView: View {
    @State private var shouldNavigate = false
    @State private var isError = false
    @State private var errorMessage = ""
    
    @Binding private var lifts: [Lift]
    
    private var repo: AppRepository
    
    @ObservedObject var exercise: Exercise
    
    init(repo: AppRepository, exercise: Exercise, lifts: Binding<[Lift]>) {
        self.repo = repo
        self.exercise = exercise
        self._lifts = lifts
    }
    
    var body: some View {
        VStack {
            NavigationLink(
                destination:AddSetToExerciseSheet(exerciseSets: $exercise.sets),
                isActive: $shouldNavigate) {
                    EmptyView()
                }
            Form {
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
                    }
                }
            }
        }.navigationTitle(exercise.lift.name)
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

struct ExerciseDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        let liftRepo = CoreDataRepository()
        let squat = Lift(name: "Squat", trainingMax: 315)
        let lifts = [squat]
        let sets = [
            ExerciseSet(reps: 5, weight: 250)
        ]
        let exercise = Exercise(id: UUID(), sets: sets, lift: squat, isComplete: false)
        return NavigationView {
            ExerciseDetailsView(repo: liftRepo, exercise: exercise, lifts: .constant(lifts))
        }
    }
}
