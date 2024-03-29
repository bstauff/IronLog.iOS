//
//  ActiveWarmupView.swift
//  Ironlog
//
//  Created by Brian Stauff on 1/7/23.
//

import SwiftUI

struct ActiveWarmupView: View {
    @ObservedObject var workout: FslAmrapWorkout
    
    var onComplete: () -> Void
    
    private var warmupExercises: [WarmupExercise] {
        return workout.warmupExercises?.array as? [WarmupExercise] ?? []
    }
    
    var body: some View {
        List {
            ForEach(warmupExercises) { exercise in
                Section {
                    ExerciseCompletionView(exercise: exercise)
                }
            }
            Section {
                HStack {
                    Spacer()
                    Button("Complete") {
                        self.onComplete()
                    }
                    Spacer()
                }
            }
        }
        .navigationTitle("Warmup")
    }
}

struct ActiveWarmupView_Previews: PreviewProvider {
    static var previews: some View {
        let workout = try! PersistenceController.preview.container.viewContext.fetch(FslAmrapWorkout.fetchRequest()).first!
        return ActiveWarmupView(workout: workout){ }
    }
}
