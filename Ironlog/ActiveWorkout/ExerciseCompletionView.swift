//
//  ExerciseCompletionVIew.swift
//  Ironlog
//
//  Created by Brian Stauff on 10/3/22.
//

import SwiftUI

struct ExerciseCompletionView: View {
    @Environment(\.managedObjectContext) var viewContext
    
    @ObservedObject var exercise: Exercise
    
    var body: some View {
        VStack {
            Text(exercise.lift?.name ?? "")
                .font(.headline)
            ForEach(getSets()){ exerciseSet in
                ExerciseCompletionRowView(exerciseSet: exerciseSet)
            }
        }
    }
    
    private func getSets() -> [ExerciseSet] {
        let exerciseSets = exercise.exerciseSets?.array as? [ExerciseSet]
        
        return exerciseSets ?? []
    }
}

struct ExerciseCompletionView_Previews: PreviewProvider {
    static var previews: some View {
        let viewContext = PersistenceController.preview.container.viewContext
        let exercise = try! viewContext.fetch(Exercise.fetchRequest()).first!
        ExerciseCompletionView(exercise: exercise)
            .environment(\.managedObjectContext, viewContext)
    }
}
