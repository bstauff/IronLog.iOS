//
//  ActiveAssistanceView.swift
//  Ironlog
//
//  Created by Brian Stauff on 1/11/23.
//

import SwiftUI

struct ActiveAssistanceView: View {
    @ObservedObject var workout: FslAmrapWorkout
    
    var onComplete: () -> Void
    
    private var assistanceExercises: [AssistanceExercise] {
        return workout.assistanceExercises?.array as? [AssistanceExercise] ?? []
    }
    
    var body: some View {
        List {
            ForEach(assistanceExercises) { exercise in
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
        .navigationTitle("Assistance")
    }
}

struct ActiveAssistanceView_Previews: PreviewProvider {
    static var previews: some View {
        let workout = try! PersistenceController.preview.container.viewContext.fetch(FslAmrapWorkout.fetchRequest()).first!
        ActiveAssistanceView(workout: workout) { }
    }
}
