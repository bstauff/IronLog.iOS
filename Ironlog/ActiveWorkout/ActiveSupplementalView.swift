//
//  ActiveSupplementalView.swift
//  Ironlog
//
//  Created by Brian Stauff on 1/11/23.
//

import SwiftUI

struct ActiveSupplementalView: View {
    @ObservedObject var supplementalExercise: SupplementalExercise
    
    var onComplete: () -> Void
    
    var body: some View {
        List {
            Section {
                ExerciseCompletionView(exercise: supplementalExercise)
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
        .navigationTitle("Supplemental")
    }
}

struct ActiveSupplementalView_Previews: PreviewProvider {
    static var previews: some View {
        let workout = try! PersistenceController.preview.container.viewContext.fetch(FslAmrapWorkout.fetchRequest()).first!
        ActiveSupplementalView(supplementalExercise: workout.supplementalExercise!) { }
    }
}
