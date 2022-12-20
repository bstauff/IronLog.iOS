//
//  ActiveWorkoutExerciseView.swift
//  Ironlog
//
//  Created by Brian Stauff on 4/23/22.
//

import SwiftUI

struct ExerciseCompletionRowView: View {
    @ObservedObject var exercise: ExerciseModel
    
    var body: some View {
        VStack {
            HStack {
                Text("Done").font(.headline)
                Spacer()
                Text("reps")
                Spacer()
                Text("weight")
            }
//            ForEach(exercise.exerciseSets){ exerciseset in
//                HStack {
//                    Toggle(isOn: exerciseset.isComplete) {
//                       Text("done")
//                    }
//                        .toggleStyle(.button)
//                        .onChange(of: exerciseset.isComplete) { value in
//                        }
//                    Spacer()
//                    Text(String(exerciseset.reps))
//                    Spacer()
//                    Text(String(exerciseset.weight))
//                }
//            }
        }
    }
}

struct ExerciseCompletionRowView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let exercise = try? viewContext.fetch(ExerciseModel.fetchRequest()).first
        return ExerciseCompletionRowView(exercise: exercise!)
    }
}
