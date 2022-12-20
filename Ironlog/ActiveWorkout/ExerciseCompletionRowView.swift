//
//  ActiveWorkoutExerciseView.swift
//  Ironlog
//
//  Created by Brian Stauff on 4/23/22.
//

import SwiftUI

struct ExerciseCompletionRowView: View {
    @Environment(\.managedObjectContext) var viewContext
    @ObservedObject var exerciseSet: ExerciseSetModel
    
    var body: some View {
        HStack {
            Toggle(isOn: $exerciseSet.isComplete) {
                Text("done")
            }
            .onChange(of: exerciseSet.isComplete) { complete in
//                try! viewContext.save()
            }
            .toggleStyle(.button)
            Spacer()
            Text(String(exerciseSet.reps))
            Spacer()
            Text(String(exerciseSet.weight))
        }
    }
}

struct ExerciseCompletionRowView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let exercise = try? viewContext.fetch(ExerciseModel.fetchRequest()).first
        return ExerciseCompletionRowView(exerciseSet: exercise!.exerciseSets?.firstObject! as! ExerciseSetModel)
    }
}
