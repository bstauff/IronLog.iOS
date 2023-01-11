//
//  ActiveMainView.swift
//  Ironlog
//
//  Created by Brian Stauff on 1/10/23.
//

import SwiftUI

struct ActiveMainView: View {
    @ObservedObject var mainExercise: MainExercise
    
    var onComplete: () -> Void
    
    var body: some View {
        List {
            Section {
                ExerciseCompletionView(exercise: mainExercise)
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
    }
}

struct ActiveMainView_Previews: PreviewProvider {
    static var previews: some View {
        let workout = try! PersistenceController.preview.container.viewContext.fetch(FslAmrapWorkout.fetchRequest()).first!
        ActiveMainView(mainExercise: workout.mainExercise!) { }
    }
}
